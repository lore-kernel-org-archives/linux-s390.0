Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728043AbfHEO0D (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 5 Aug 2019 10:26:03 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x75EMXPc014284
        for <linux-s390@vger.kernel.org>; Mon, 5 Aug 2019 10:26:02 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u6jwf21k2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 05 Aug 2019 10:25:58 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 5 Aug 2019 15:25:51 +0100
Subject: Re: [PATCH v12 01/11] MODSIGN: Export module signature definitions
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 05 Aug 2019 10:25:41 -0400
In-Reply-To: <20190805151123.12510d72@laptop-ibm>
References: <20190628021934.4260-1-bauerman@linux.ibm.com>
         <20190628021934.4260-2-bauerman@linux.ibm.com>
         <20190701144752.GC25484@linux-8ccs> <87lfxel2q6.fsf@morokweng.localdomain>
         <20190704125427.31146026@laptop-ibm> <874l41ocf5.fsf@morokweng.localdomain>
         <20190705150000.372345b0@laptop-ibm> <8736iw9y00.fsf@morokweng.localdomain>
         <20190805151123.12510d72@laptop-ibm>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <1565015141.11223.145.camel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Philipp Rudo <prudo@linux.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Jessica Yu <jeyu@kernel.org>, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org

On Mon, 2019-08-05 at 15:11 +0200, Philipp Rudo wrote:
> Hi Thiago,
> 
> > > The patch looks good now.  
> > 
> > Thanks! Can I add your Reviewed-by?
> 
> sorry, for the late answer, but I was on vacation the last two weeks. I hope
> it's not too late now.
> 
> Reviewed-by: Philipp Rudo <prudo@linux.ibm.com>

Thanks!  This patch set is still in the #next-queued-testing
branch.  I'm still hoping for a few more tags, before pushing it out
to the #next-integrity branch later today.

Mimi
