From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH 8/8] socket: Add SO_TIMESTAMPING_NEW
Date: Sat, 24 Nov 2018 21:07:35 -0800
Message-ID: <CABeXuvoRPAFa5v86pp+WmBkjzbHZSJqjzibL1+Zx8Uas6bvohg@mail.gmail.com>
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-9-deepa.kernel@gmail.com> <CAF=yD-Jz8c2EsoKxUDbf7dygWRW49kwteUsksq3eUV00Eg94-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAF=yD-Jz8c2EsoKxUDbf7dygWRW49kwteUsksq3eUV00Eg94-w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: willemdebruijn.kernel@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Network Devel Mailing List <netdev@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, Chris Zankel <chris@zankel.net>, fenghua.yu@intel.com, rth@twiddle.net, Thomas Gleixner <tglx@linutronix.de>, ubraun@linux.ibm.com, linux-alpha@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, linux-ia64@vger.kernel.org, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-xtensa@linux-xtensa.org, sparclinux <sparclinux@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

> > +               new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
> > +               if (new_tstamp)
>
> nit: no need for explicit variable

Sure, will drop it.

-Deepa
