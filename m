Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728312AbgBQLeJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 06:34:09 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HBW0Xu035530
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 06:34:08 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y6bp032tj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 06:34:07 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 17 Feb 2020 11:33:21 -0000
Subject: Re: [PATCH v2 19/42] KVM: s390: protvirt: Add new gprs location
 handling
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-20-borntraeger@de.ibm.com>
 <38b60f61-db18-ee7a-6b8e-192a7bb9d259@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 17 Feb 2020 12:33:15 +0100
MIME-Version: 1.0
In-Reply-To: <38b60f61-db18-ee7a-6b8e-192a7bb9d259@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <7cd5dbca-6693-d1f1-dff4-8479f080c921@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 17.02.20 12:01, David Hildenbrand wrote:

> As discussed, I think there is room for improvement in the future (which
> we could have documented in the patch description), because this is
> obviously sub-optimal.
> 

Will use the following as patch description
  
Guest registers for protected guests are stored at offset 0x380.  We
will copy those to the usual places.  Long term we could refactor this
or use register access functions.


> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
