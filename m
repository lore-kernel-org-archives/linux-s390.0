Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726694AbgAJJFi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Jan 2020 04:05:38 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00A8vfk2038213
        for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2020 04:05:37 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xeeywbf6n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2020 04:05:37 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 10 Jan 2020 09:05:35 -0000
Subject: Re: [PATCH v4] KVM: s390: Add new reset vcpu API
References: <20200109155602.18985-1-frankja@linux.ibm.com>
 <20200109180841.6843cb92.cohuck@redhat.com>
 <f79b523e-f3e8-95b8-c242-1e7ca0083012@linux.ibm.com>
 <f18955c0-4002-c494-b14e-1b9733aad20e@redhat.com>
 <c0049bfb-9516-a382-c69c-0693cb0fbfda@linux.ibm.com>
 <90f65536-c2bb-9234-aef4-7941d477369e@linux.ibm.com>
 <ed25755c-0c5c-039b-7ab5-89a714729357@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 10 Jan 2020 10:05:30 +0100
MIME-Version: 1.0
In-Reply-To: <ed25755c-0c5c-039b-7ab5-89a714729357@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <94487666-c518-de30-12e6-1848ab3a8313@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com



On 10.01.20 09:49, Thomas Huth wrote:

> 
> As you said, it's mostly a matter of taste, but at least in my eyes this
> approach with fallthroughs and the additional parameter looks rather
> harder to understand compared to what I've suggested.

Agreed. A parameter makes the code harder to grasp.
