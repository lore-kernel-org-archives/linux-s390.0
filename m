From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH net-next 1/3] tcp: introduce TCP experimental option for
 SMC
Date: Wed, 08 Jul 2015 07:53:10 +0200
Message-ID: <1436334790.24939.1.camel@edumazet-glaptop2.roam.corp.google.com>
References: <1436195511-32314-1-git-send-email-ubraun@linux.vnet.ibm.com>
	 <1436195511-32314-2-git-send-email-ubraun@linux.vnet.ibm.com>
	 <1436198897.4571.7.camel@edumazet-glaptop2.roam.corp.google.com>
	 <1436277433.18112.7.camel@BR9GV9YG.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1436277433.18112.7.camel@BR9GV9YG.de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Ursula Braun <ubraun@linux.vnet.ibm.com>
Cc: davem@davemloft.net, utz.bacher@de.ibm.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org, ursula.braun@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2015-07-07 at 15:57 +0200, Ursula Braun wrote:
> Eric,
> 
> understood, would it be acceptable if the SMC-specific hooks in the
> TCP-code are enclosed with "#ifdef CONFIG_SMC ... #endif"?

If this CONFIG_SMC is enabled only on relevant builds, I guess it would
be ok. (Try to use helpers in include files to avoid spreading new
#ifdef in C files)
