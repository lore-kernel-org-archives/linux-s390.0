Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14926 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404351AbgFXP4b (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 24 Jun 2020 11:56:31 -0400
Subject: Re: linux-next: umh: fix processed error when UMH_WAIT_PROC is used
 seems to break linux bridge on s390x (bisected)
References: <20200610154923.27510-5-mcgrof@kernel.org>
 <20200623141157.5409-1-borntraeger@de.ibm.com>
 <b7d658b9-606a-feb1-61f9-b58e3420d711@de.ibm.com>
 <3118dc0d-a3af-9337-c897-2380062a8644@de.ibm.com>
 <20200624144311.GA5839@infradead.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <9e767819-9bbe-2181-521e-4d8ca28ca4f7@de.ibm.com>
Date: Wed, 24 Jun 2020 17:54:46 +0200
MIME-Version: 1.0
In-Reply-To: <20200624144311.GA5839@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: mcgrof@kernel.org, ast@kernel.org, axboe@kernel.dk, bfields@fieldses.org, bridge@lists.linux-foundation.org, chainsaw@gentoo.org, christian.brauner@ubuntu.com, chuck.lever@oracle.com, davem@davemloft.net, dhowells@redhat.com, gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, josh@joshtriplett.org, keescook@chromium.org, keyrings@vger.kernel.org, kuba@kernel.org, lars.ellenberg@linbit.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, nikolay@cumulusnetworks.com, philipp.reisner@linbit.com, ravenexp@gmail.com, roopa@cumulusnetworks.com, serge@hallyn.com, slyfox@gentoo.org, viro@zeniv.linux.org.uk, yangtiezhu@loongson.cn, netdev@vger.kernel.org, markward@linux.ibm.com, linux-s390 <linux-s390@vger.kernel.org>



On 24.06.20 16:43, Christoph Hellwig wrote:
> On Wed, Jun 24, 2020 at 01:11:54PM +0200, Christian Borntraeger wrote:
>> Does anyone have an idea why "umh: fix processed error when UMH_WAIT_PROC is used" breaks the
>> linux-bridge on s390?
> 
> Are we even sure this is s390 specific and doesn't happen on other
> architectures with the same bridge setup?

Fair point. AFAIK nobody has tested this yet on x86.
