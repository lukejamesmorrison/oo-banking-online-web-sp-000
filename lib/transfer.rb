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

    if valid? && !transfer_exists? && @sender.balance >= @amount
      # Subtract amount from sender
      @sender.balance -= amount
      # Add amount to receiver
      @receiver.deposit(amount)
      # Update status to complete
      @status = 'complete'
      # Add tranfer to @@all to prevent duplicates
      @@all << self
    else
      @status = 'rejected'
      return "Transaction rejected. Please check your account balance."
    end
  end

  def transfer_exists?
    @@all.include?(self)
  end

  def reverse_transfer
    
  end

end
