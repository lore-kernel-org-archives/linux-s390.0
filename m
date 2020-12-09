Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbgLIJCb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Dec 2020 04:02:31 -0500
Subject: Re: [kvm-unit-tests PATCH 0/2] s390x: Move from LGPL 2 to GPL 2
References: <20201208150902.32383-1-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <c91bd49f-4d4d-42d3-7551-195d0d77060a@de.ibm.com>
Date: Wed, 9 Dec 2020 10:01:45 +0100
MIME-Version: 1.0
In-Reply-To: <20201208150902.32383-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org



On 08.12.20 16:09, Janosch Frank wrote:
> KVM and the KVM unit tests should be able to share code to improve
> development speed and the LGPL is currently preventing us from doing
> exactly that. Additionally we have a multitude of different licenses
> in s390x files: GPL 2 only, GPL 2 or greater, LGPL 2 and LGPL 2.1 or
> later.
> 
> This patch set tries to move the licenses to GPL 2 where
> possible. Also we introduce the SPDX identifiers so the file headers
> are more readable.
> 

Makes perfect sense.
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com
