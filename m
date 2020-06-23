Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22606 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730977AbgFWHNW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 23 Jun 2020 03:13:22 -0400
Subject: Re: [PATCH v9 0/2] Use DIAG318 to set Control Program Name & Version
 Codes
References: <20200622154636.5499-1-walling@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <cfe77de0-e1d8-5779-541f-286cf3002459@de.ibm.com>
Date: Tue, 23 Jun 2020 09:13:15 +0200
MIME-Version: 1.0
In-Reply-To: <20200622154636.5499-1-walling@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Collin Walling <walling@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com



On 22.06.20 17:46, Collin Walling wrote:
> Changelog:
> 
>     v9
> 
>     • No longer unshadowing CPNC in VSIE
> 
applied. 
