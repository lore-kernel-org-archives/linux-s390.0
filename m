Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729462AbfHENLh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 5 Aug 2019 09:11:37 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x75D3QNK140689
        for <linux-s390@vger.kernel.org>; Mon, 5 Aug 2019 09:11:36 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u6m1yb8rf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 05 Aug 2019 09:11:35 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <prudo@linux.ibm.com>;
        Mon, 5 Aug 2019 14:11:32 +0100
Date: Mon, 5 Aug 2019 15:11:23 +0200
From: Philipp Rudo <prudo@linux.ibm.com>
Subject: Re: [PATCH v12 01/11] MODSIGN: Export module signature definitions
In-Reply-To: <8736iw9y00.fsf@morokweng.localdomain>
References: <20190628021934.4260-1-bauerman@linux.ibm.com>
        <20190628021934.4260-2-bauerman@linux.ibm.com>
        <20190701144752.GC25484@linux-8ccs>
        <87lfxel2q6.fsf@morokweng.localdomain>
        <20190704125427.31146026@laptop-ibm>
        <874l41ocf5.fsf@morokweng.localdomain>
        <20190705150000.372345b0@laptop-ibm>
        <8736iw9y00.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190805151123.12510d72@laptop-ibm>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Jessica Yu <jeyu@kernel.org>, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org

Hi Thiago,

> > The patch looks good now.  
> 
> Thanks! Can I add your Reviewed-by?

sorry, for the late answer, but I was on vacation the last two weeks. I hope
it's not too late now.

Reviewed-by: Philipp Rudo <prudo@linux.ibm.com>
