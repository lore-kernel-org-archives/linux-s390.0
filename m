Return-Path: <netdev-owner@vger.kernel.org>
Subject: Re: [RFC PATCH v2 net-next 00/12] Make .ndo_get_stats64 sleepable
References: <20210105185902.3922928-1-olteanv@gmail.com>
 <20210106134516.jnh2b5p5oww4cghz@skbuf>
From: Jacob Keller <jacob.e.keller@intel.com>
Message-ID: <e0edda65-5421-94aa-19c5-1bd88a602f92@intel.com>
Date: Fri, 8 Jan 2021 17:26:40 -0800
MIME-Version: 1.0
In-Reply-To: <20210106134516.jnh2b5p5oww4cghz@skbuf>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Jiri Benc <jbenc@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Stephen Hemminger <stephen@networkplumber.org>, Eric Dumazet <edumazet@google.com>, George McCollister <george.mccollister@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Jay Vosburgh <j.vosburgh@gmail.com>, Veaceslav Falico <vfalico@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, Taehee Yoo <ap420073@gmail.com>, Jiri Pirko <jiri@mellanox.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>, Paolo Abeni <pabeni@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, Florian Westphal <fw@strlen.de>, linux-s390@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-parisc@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, dev@openvswitch.org



On 1/6/2021 5:45 AM, Vladimir Oltean wrote:
> On Tue, Jan 05, 2021 at 08:58:50PM +0200, Vladimir Oltean wrote:
>> This is marked as Request For Comments for a reason.
> 
> If nobody has any objections, I will remove the memory leaks I
> introduced to check if anybody is paying attention, and I will resubmit
> this as a non-RFC series.
> 

I read through this, and it makes sense to me. I admit that I still
don't grasp all the details of the locking involved.

Thanks,
Jake
