From: Ursula Braun <ubraun@linux.ibm.com>
Subject: Re: [PATCH net-next] net/smc: init conn.tx_work & conn.send_lock
 sooner
Date: Thu, 17 May 2018 18:30:38 +0200
Message-ID: <d574e3fe-42c2-ba55-724e-a4519b58b1a4@linux.ibm.com>
References: <20180517105421.182397-1-edumazet@google.com>
 <63bf1ebb-4a6f-43b8-1ee3-ced650e1dfdf@linux.ibm.com>
 <CANn89iJ7hMTjbz_-MbLt2TwsxYARKaov1MoiVMzx4jofsJrewA@mail.gmail.com>
 <c265fa3e-1359-1805-4735-d5ab0ca6b6e4@linux.ibm.com>
 <CANn89iJCjp++D=awHqPicuBqdF8dcvj9=-NF3=YUVSdxh7VgGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CANn89iJCjp++D=awHqPicuBqdF8dcvj9=-NF3=YUVSdxh7VgGQ@mail.gmail.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 05/17/2018 05:28 PM, Eric Dumazet wrote:
> On Thu, May 17, 2018 at 6:58 AM Ursula Braun <ubraun@linux.ibm.com> wrote:
> 
> 
> 
>> On 05/17/2018 02:20 PM, Eric Dumazet wrote:
>>> On Thu, May 17, 2018 at 5:13 AM Ursula Braun <ubraun@linux.ibm.com>
> wrote:
>>>
>>>> This problem should no longer show up with yesterday's net-next commit
>>>> 569bc6436568 ("net/smc: no tx work trigger for fallback sockets").
>>>
>>> It definitely triggers on latest net-next, which includes 569bc6436568
>>>
>>> Thanks.
>>>
> 
>> Sorry, my fault.
> 
>> Your proposed patch solves the problem. On the other hand the purpose of
>> smc_tx_init() has been to cover tx-related socket initializations needed
> for
>> connection sockets only. tx_work is something that should be scheduled
> only
>> for active connection sockets in non-fallback mode.
>> Thus I prefer this alternate patch to solve the problem:
> 
>> ---
>>   net/smc/af_smc.c |    8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -1362,14 +1362,18 @@ static int smc_setsockopt(struct socket
>>                  }
>>                  break;
>>          case TCP_NODELAY:
>> -               if (sk->sk_state != SMC_INIT && sk->sk_state !=
> SMC_LISTEN) {
>> +               if (sk->sk_state != SMC_INIT &&
>> +                   sk->sk_state != SMC_LISTEN &&
>> +                   sk->sk_state != SMC_CLOSED) {
>>                          if (val && !smc->use_fallback)
>>                                  mod_delayed_work(system_wq,
> &smc->conn.tx_work,
>>                                                   0);
>>                  }
>>                  break;
>>          case TCP_CORK:
>> -               if (sk->sk_state != SMC_INIT && sk->sk_state !=
> SMC_LISTEN) {
>> +               if (sk->sk_state != SMC_INIT &&
>> +                   sk->sk_state != SMC_LISTEN &&
>> +                   sk->sk_state != SMC_CLOSED) {
>>                          if (!val && !smc->use_fallback)
>>                                  mod_delayed_work(system_wq,
> &smc->conn.tx_work,
>>                                                   0);
> 
>> What do you think?
> 
> I think my patch is cleaner.
> 
> Deferring spinlock and workqueues setup is a recipe for disaster.
> 

If your solution is preferred, I agree. In this case my today's net/smc patch
   net/smc: initialize tx_work before llc initial handshake
for the net-tree is obsolete.
