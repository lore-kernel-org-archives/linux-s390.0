Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48658 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726484AbgD2OwG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 10:52:06 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03TEYroL023908
        for <linux-s390@vger.kernel.org>; Wed, 29 Apr 2020 10:52:05 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30q80prapd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 29 Apr 2020 10:52:05 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03TEZ5RO024624
        for <linux-s390@vger.kernel.org>; Wed, 29 Apr 2020 10:52:05 -0400
Subject: Re: [PATCH] s390: vfio-ap: fix some comments
References: <20191113095319.6154-1-cohuck@redhat.com>
 <42f63f2b-2fc7-4a68-a86b-886f6a4efc04@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <e7c6c14d-a7dd-3813-f7df-7fec747895f1@linux.ibm.com>
Date: Wed, 29 Apr 2020 10:52:03 -0400
MIME-Version: 1.0
In-Reply-To: <42f63f2b-2fc7-4a68-a86b-886f6a4efc04@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org

Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>

On 11/13/19 7:15 AM, Pierre Morel wrote:
> Check vfio_ap_setirq
