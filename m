From: Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next] net/smc: init conn.tx_work & conn.send_lock sooner
Date: Thu, 17 May 2018 05:20:30 -0700
Message-ID: <CANn89iJ7hMTjbz_-MbLt2TwsxYARKaov1MoiVMzx4jofsJrewA@mail.gmail.com>
References: <20180517105421.182397-1-edumazet@google.com> <63bf1ebb-4a6f-43b8-1ee3-ced650e1dfdf@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <63bf1ebb-4a6f-43b8-1ee3-ced650e1dfdf@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 17, 2018 at 5:13 AM Ursula Braun <ubraun@linux.ibm.com> wrote:

> This problem should no longer show up with yesterday's net-next commit
> 569bc6436568 ("net/smc: no tx work trigger for fallback sockets").

It definitely triggers on latest net-next, which includes 569bc6436568

Thanks.
