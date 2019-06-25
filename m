Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732238AbfFYPU5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Jun 2019 11:20:57 -0400
Subject: Re: [PATCH v5 0/2] Use DIAG318 to set Control Program Name & Version
 Codes
From: Collin Walling <walling@linux.ibm.com>
References: <1561475022-18348-1-git-send-email-walling@linux.ibm.com>
Message-ID: <7c97cf39-8b93-f90b-94d4-27a29ef355c6@linux.ibm.com>
Date: Tue, 25 Jun 2019 11:20:44 -0400
MIME-Version: 1.0
In-Reply-To: <1561475022-18348-1-git-send-email-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: cohuck@redhat.com, david@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org

On 6/25/19 11:03 AM, Collin Walling wrote:
> Changelog:
> 
>      v5
>          - s/cpc/diag318_info in order to make the relevant data more clear
>          - removed mutex locks for diag318_info get/set
> 
>      v4
>          - removed setup.c changes introduced in bullet 1 of v3
>          - kept diag318_info struct cleanup
>          - analogous QEMU patches:

Correct link to QEMU patches:
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg05535.html

	
