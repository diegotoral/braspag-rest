module BraspagRest
  class RecurrentPayment < Hashie::IUTrash
    property :end_date, from: 'EndDate'
    property :interval, from: 'Interval'
    property :authorize_now, from: 'AuthorizeNow'
  end
end
