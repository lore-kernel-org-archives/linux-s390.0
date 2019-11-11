Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726853AbfKKJIM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 Nov 2019 04:08:12 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAB94Ca6143434
        for <linux-s390@vger.kernel.org>; Mon, 11 Nov 2019 04:08:11 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w7259dxgg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 11 Nov 2019 04:08:10 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 11 Nov 2019 09:08:08 -0000
Subject: Re: [v3] s390/pkey: Use memdup_user() rather than duplicating its
 implementation
References: <08422b7e-2071-ee52-049e-c3ac55bc67a9@web.de>
 <6137855bb4170c438c7436cbdb7dfd21639a8855.camel@perches.com>
 <deb7893f-3cfe-18fc-3feb-b26b290bf3c6@web.de>
 <833d7d5e-6ede-6bdd-a2cc-2da7f0b03908@de.ibm.com>
 <1b65bc81-f47a-eefa-f1f4-d5af6a1809c0@web.de>
 <733b29df-207e-a165-ee80-46be8720c0c4@de.ibm.com>
 <8f98f9fc-57df-5993-44b5-5ea4c0de7ef9@web.de>
 <c0df9cc8-c41a-1e5d-811c-1ff045c13fcc@de.ibm.com>
 <61244676-8ac1-20af-ed94-99e19c1f95d5@web.de>
 <040f3e18-d97a-fc32-b237-20e7553e1733@de.ibm.com>
 <c701adc9-dab2-46af-003f-d8a2c47bc0af@web.de>
 <ad1c533d-8e7f-b17e-d9cb-54dd9a7ed012@de.ibm.com>
 <a2dbda2a-1c2f-20f1-6b97-c59dbbcaa7a8@web.de>
 <6de4f605-6f74-a3b6-92d5-c5162cb54a6f@de.ibm.com>
 <ae4cb7b4-68e7-f989-be4b-1a9df8ce51ed@web.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 11 Nov 2019 10:08:03 +0100
MIME-Version: 1.0
In-Reply-To: <ae4cb7b4-68e7-f989-be4b-1a9df8ce51ed@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f46d8b65-bb64-db04-aa7c-db980fce1ae1@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>, linux-s390@vger.kernel.org, Harald Freudenberger <freude@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Franzki <ifranzki@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Joe Perches <joe@perches.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>, Navid Emamdoost <emamd001@umn.edu>, Stephen McCamant <smccaman@umn.edu>



On 11.11.19 10:06, Markus Elfring wrote:
>>> Does hinder you anything from continuing to use the previous known email address?
>>
>> Can you at least send a mail from sourceforge address with the Signed-off-by?
> 
> Not any more (for a while).

Then I will not apply that patch with that email and signoff.
