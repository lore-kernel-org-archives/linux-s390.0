Return-Path: <owner-linux-mm@kvack.org>
Date: Thu, 11 May 2017 10:35:38 -0400 (EDT)
Message-Id: <20170511.103538.1094530388932292836.davem@davemloft.net>
Subject: Re: [v3 0/9] parallelized "struct page" zeroing
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170511080537.GE26782@dhcp22.suse.cz>
References: <20170510145726.GM31466@dhcp22.suse.cz>
	<20170510.111943.1940354761418085760.davem@davemloft.net>
	<20170511080537.GE26782@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: mhocko@kernel.org
Cc: pasha.tatashin@oracle.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Michal Hocko <mhocko@kernel.org>
Date: Thu, 11 May 2017 10:05:38 +0200

> Anyway, do you agree that doing the struct page initialization along
> with other writes to it shouldn't add a measurable overhead comparing
> to pre-zeroing of larger block of struct pages?  We already have an
> exclusive cache line and doing one 64B write along with few other stores
> should be basically the same.

Yes, it should be reasonably cheap.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
