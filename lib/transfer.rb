class Transfer

  attr_reader :sender, :receiver, :status, :amount

  @@all = []

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @amount = amount
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if  valid?
        && !transfer_exists?
        && has_sufficient_funds?(@sender)
      # Subtract amount from sender
      @sender.balance -= amount
      # Add amount to receiver
      @receiver.deposit(amount)
      # Update status to complete
      @status = 'complete'
      # Add tranfer to @@all to prevent duplicates
      @@all << self
    end

    def transfer_exists?
      @@all.include?(self)
    end

    def has_sufficient_funds?(account)
      account.balance > 0
    end
  end

end
