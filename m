Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55352 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727324AbgIYQIN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Sep 2020 12:08:13 -0400
Subject: Re: [PATCH v1 1/4] memory: allocation in low memory
From: Pierre Morel <pmorel@linux.ibm.com>
References: <1601049764-11784-1-git-send-email-pmorel@linux.ibm.com>
 <1601049764-11784-2-git-send-email-pmorel@linux.ibm.com>
Message-ID: <769e3e7e-7bf1-4974-77da-a260b033f151@linux.ibm.com>
Date: Fri, 25 Sep 2020 18:08:05 +0200
MIME-Version: 1.0
In-Reply-To: <1601049764-11784-2-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com


Arrrghh sorry, I forgot the kvm-unit-tests TAG


On 2020-09-25 18:02, Pierre Morel wrote:
> Some architectures need allocations to be done under a
> specific address limit to allow DMA from I/O.
> 
> We propose here a very simple page allocator to get
> pages allocated under this specific limit.
> 
> The DMA page allocator will only use part of the available memory
> under the DMA address limit to let room for the standard allocator.
> 
-- 
Pierre Morel
IBM Lab Boeblingen
