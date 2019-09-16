Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728932AbfIPRxW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 16 Sep 2019 13:53:22 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8GHe2n8081728
        for <linux-s390@vger.kernel.org>; Mon, 16 Sep 2019 13:53:18 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v2djdbjq5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 16 Sep 2019 13:53:18 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sebott@linux.ibm.com>;
        Mon, 16 Sep 2019 18:53:15 +0100
Date: Mon, 16 Sep 2019 19:53:10 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH] s390/cio: fix intparm documentation
In-Reply-To: <20190911164103.16156-1-cohuck@redhat.com>
References: <20190911164103.16156-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1909161946570.3883@schleppi>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 11 Sep 2019, Cornelia Huck wrote:
> The common I/O layer is maintaining an "intparm" inspired by
> the hardware intparm for driver usage. This "intparm" is not
> only applicaple for ssch, but also for hsch/csch. The kerneldoc
> states that it is only updated for hsch/csch if no prior request
> is pending; however, this is not what the code does (whether
> that would actually desireable is a different issue.)
> 
> Let's at least fix the kerneldoc for now.
> 
> Fixes: b2ffd8e9a76e ("[S390] cio: Add docbook comments.")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

I did a similar patch after a discusion with a colleague a couple of
months ago but totally forgot about that... yours has better description
and kdoc anyway ;-)

Applied. Thanks!
