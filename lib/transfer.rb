class Transfer

  attr_reader :sender, :receiver, :status, :amount

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
    if valid?
      # Subtract amount from sender
      @sender.balance -= amount
      # Add amount to receiver
      @receiver.deposit(amount)

      @status = 'complete'
    end
  end

end
