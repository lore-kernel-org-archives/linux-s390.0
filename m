Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18882 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730984AbgFPQLp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Jun 2020 12:11:45 -0400
Subject: Re: [kvm-unit-tests PATCH v9 01/12] s390x: Use PSW bits definitions
 in cstart
From: Pierre Morel <pmorel@linux.ibm.com>
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-2-git-send-email-pmorel@linux.ibm.com>
 <f160d328-694a-4476-4863-c49a1d0e5349@redhat.com>
 <eebf1927-f1b2-cca0-529a-9a97c761345d@linux.ibm.com>
Message-ID: <fc27e211-2d9c-63f1-4f10-ca3d744a3ea7@linux.ibm.com>
Date: Tue, 16 Jun 2020 18:11:37 +0200
MIME-Version: 1.0
In-Reply-To: <eebf1927-f1b2-cca0-529a-9a97c761345d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com



On 2020-06-16 18:08, Pierre Morel wrote:
> 
> 
> On 2020-06-16 15:13, Thomas Huth wrote:
>> On 15/06/2020 11.31, Pierre Morel wrote:
>>> This patch defines the PSW bits EA/BA used to initialize the PSW masks
>>> for exceptions.
> 

> 
> Should I keep your RB for the arch_def.h ?
> 

Hi, sorry, the changes in arch_def go are not used any more so...

-- 
Pierre Morel
IBM Lab Boeblingen
