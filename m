Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9DFC64EC4
	for <linux-s390@archiver.kernel.org>; Fri, 10 Mar 2023 13:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCJNUn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 10 Mar 2023 08:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjCJNUm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Mar 2023 08:20:42 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C83BF8E47
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 05:20:39 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AAoL0X023338
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5luuMZKKG+vU7Vrz7VvLf9Jjk57ZskRqqUurhhZaj7Q=;
 b=tewNh8Sc2TEtUJ3Gs8LwfnZ9EVEO/X/d0tl3Tx7A++3LB4C+rv1gCs8mc7GMaXtJquty
 VSTKYjxVttKlJye3HX4OwEj2W+rfcBplQ/LOjHVEZgbO6KWvJdXU+omr7rtYQ6SKtTLQ
 CZG6xvey82DKHM//AGxoyoLPmTnKSh7EflOu/aUYoAWWq77YEyILYM4lXJ/eCkG1Msoz
 zEijS/ZCye5j6eDGjvwuv9g/yauaZLZ2e4jHcxXL7baHOfRl9s/DXcF08mDCzawExXLn
 yinINK1uc0MIrNMx5OIAL67U/ILPcFstUM2T6QMIVe3CJVWSOtPyL6hY7Km889it4POf fA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p7j15w96q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:20:38 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32A7jmT7003378
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:20:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3p6g0jjwm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:20:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ADKWW2655882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 13:20:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0CF92004F;
        Fri, 10 Mar 2023 13:20:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 593B22004B;
        Fri, 10 Mar 2023 13:20:32 +0000 (GMT)
Received: from [9.171.92.206] (unknown [9.171.92.206])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Mar 2023 13:20:32 +0000 (GMT)
Message-ID: <64918275-3f63-68c5-1c82-ff2b60114662@linux.ibm.com>
Date:   Fri, 10 Mar 2023 14:20:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1] s390: ipl: fix physical-virtual confusion for diag308
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, mhartmay@linux.ibm.com
References: <20230310122204.1898-1-nrb@linux.ibm.com>
 <ZAsjzoA07NTYENku@tuxmaker.boeblingen.de.ibm.com>
 <ZAslxw+V0FY9bYLF@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
Content-Language: en-US
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <ZAslxw+V0FY9bYLF@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CwoWucLgbpBbjdzomNeLVwOnYmFS9zPz
X-Proofpoint-GUID: CwoWucLgbpBbjdzomNeLVwOnYmFS9zPz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_03,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 mlxscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=700 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100104
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



Am 10.03.23 um 13:42 schrieb Alexander Gordeev:
> On Fri, Mar 10, 2023 at 01:34:27PM +0100, Alexander Gordeev wrote:
>>> Note that several callers pass NULL as addr, this is fine since
>>> virt_to_phys(0) == 0.
> 
> Missed that.
> 
> Are you sure? Quickly checked ppc64, x86 and arm64 - they do not
> seem adhere virt_to_phys(0) == 0, nor the VR kernel (so far).

Isnt that the prefix page? I think we did say that the prefix page must be 0 in virt and phys otherwise we will have performance issues due to cache synonyms.
