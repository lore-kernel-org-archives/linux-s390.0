Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4CE2B7CC.9010708@redhat.com>
Date: Tue, 16 Nov 2010 18:56:44 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH v2 4/7] taskstats: Add per task steal time accounting
References: <20101111170352.732381138@linux.vnet.ibm.com>	 <20101111170815.024542355@linux.vnet.ibm.com>	 <1289677083.2109.167.camel@laptop>	 <20101115155057.15f3be35@mschwide.boeblingen.de.ibm.com>	 <1289833883.2109.494.camel@laptop>	 <20101115184206.4463fd05@mschwide.boeblingen.de.ibm.com>	 <1289843441.2109.520.camel@laptop>	 <20101115185923.1c353d07@mschwide.boeblingen.de.ibm.com>	 <1289844524.2109.524.camel@laptop>	 <20101116095101.5d86d1e5@mschwide.boeblingen.de.ibm.com>	 <1289909768.2109.592.camel@laptop>	 <20101116163325.755a709f@mschwide.boeblingen.de.ibm.com>	 <1289922329.2109.627.camel@laptop>  <4CE2B37F.8050808@redhat.com> <1289925806.2109.628.camel@laptop>
In-Reply-To: <1289925806.2109.628.camel@laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Shailabh Nagar <nagar1234@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Venkatesh Pallipadi <venki@google.com>, Suresh Siddha <suresh.b.siddha@intel.com>, Ingo Molnar <mingo@elte.hu>, Oleg Nesterov <oleg@redhat.com>, John stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Balbir Singh <balbir@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, "jeremy.fitzhardinge" <jeremy.fitzhardinge@citrix.com>
List-ID: <linux-s390.vger.kernel.org>

On 11/16/2010 06:43 PM, Peter Zijlstra wrote:
>
>> No.  Hypercalls are voluntary and known, but most exits are involuntary
>> and unknown to the guest.  Any memory access can generate a page fault,
>> and any host interrupt will exit the guest.
> Right, but we could not make the guest jump to a special stub on vcpu
> enter? I guess we could simply because we have the hypervisor under
> control.

No, some entries inject an interrupt or exception, so the next rip value 
is unknown (without doing a lot of extra slow calculations).
