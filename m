Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24332 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391334AbfGOOZd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Jul 2019 10:25:33 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6FEMR5R142594
        for <linux-s390@vger.kernel.org>; Mon, 15 Jul 2019 10:25:33 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2trsahey5g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 15 Jul 2019 10:25:32 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 15 Jul 2019 15:25:30 +0100
Date: Mon, 15 Jul 2019 16:25:23 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/protvirt: restore force_dma_unencrypted()
In-Reply-To: <20190715142045.GA908@infradead.org>
References: <20190715131719.100650-1-pasic@linux.ibm.com>
        <20190715132027.GA18357@infradead.org>
        <7e393b48-4165-e1d4-0450-e52dd914a3cd@amd.com>
        <20190715142045.GA908@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190715162523.10803828.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Mon, 15 Jul 2019 07:20:45 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> Ok,
> 
> I've folded the minimal s390 fix in, please both double check that this
> is ok as the minimally invasive fix:
> 
> http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/7bb9bbcee8845af663a7a60df9e2cc24422b3de5
> 
> The s390 fix to clean up sev_active can then go into the series that
> Thiago is working on.
> 

Works with me.

Regards,
Halil
