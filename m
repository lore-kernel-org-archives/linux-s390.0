From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH/RFC net-next 0/4] Delete token ring support.
Date: Tue, 15 May 2012 17:48:15 -0700
Message-ID: <m2k40dkl2o.fsf@firstfloor.org>
References: <1337128544-18680-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1337128544-18680-1-git-send-email-paul.gortmaker@windriver.com>
	(Paul Gortmaker's message of "Tue, 15 May 2012 20:35:40 -0400")
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:
>
> What I mean by (2) is the implicit absence of anyone fixing _runtime_
> bugs, going all the way back to 2.6.12 in 2005.  If the code was being
> _used_, we'd see runtime regressions reported and their associated
> fixes.

Removal sounds good to me. In fact I would argue to remove any other driver
which did not get a real change since 2005 too.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
