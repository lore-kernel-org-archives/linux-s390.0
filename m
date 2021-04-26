Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE672C433ED
	for <linux-s390@archiver.kernel.org>; Mon, 26 Apr 2021 12:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8740F6100C
	for <linux-s390@archiver.kernel.org>; Mon, 26 Apr 2021 12:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhDZMjL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 26 Apr 2021 08:39:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233528AbhDZMjK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 26 Apr 2021 08:39:10 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QCYYoV063197;
        Mon, 26 Apr 2021 08:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UXehgUqKcgxK6SAzMZ1pfiA0zcm7P8krEYI90Re0uzw=;
 b=k6k6yYgRwwJK7anhzGVNr+MFHzhZ0Bc4aMPW/acSnTKGEbhJdwdDLKYO0L6St15UrcE3
 hebocuKwTGG3kiJYdzoXfCrvzSBrgafWMVBYXBuK0hxTixuTRY1s69O/TW7fEYokTzsY
 RripSR53XV5qX4gA+MHkgN3oweLExXkGHryzJNVsIwwLvy4MQArPHd81+EIKJYkPkbjx
 h29SSs2dDrl0PfetgKCM18CzYTYAOdpioBS3Ub1GcYDQBUzWmZKZAMeeC20zHtDOQdY+
 F37QvBOkzAywUlTAmFbVcK6Pz3uQRmORrDqI1o08VazWEJ7932EQJEXT84pIjZ8eOcSa Ow== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 385w4e99ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 08:38:27 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13QCalhn007580;
        Mon, 26 Apr 2021 12:38:25 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 384ay80emr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 12:38:25 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13QCcLI338863292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 12:38:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27A52AE055;
        Mon, 26 Apr 2021 12:38:21 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF431AE051;
        Mon, 26 Apr 2021 12:38:20 +0000 (GMT)
Received: from [9.145.43.86] (unknown [9.145.43.86])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 26 Apr 2021 12:38:20 +0000 (GMT)
Subject: Re: [PATCH] s390/cio: Remove the invalid condition on IO_SCH_UNREG
To:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        christian.ehrhardt@canonical.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org
References: <20210423100843.2230969-1-vneethv@linux.ibm.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <ca1e885c-0cc4-8e66-e05f-a1af62f1b3c9@linux.ibm.com>
Date:   Mon, 26 Apr 2021 14:38:20 +0200
MIME-Version: 1.0
In-Reply-To: <20210423100843.2230969-1-vneethv@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pW7kyiSrn8Z6st91FAJGohfO1fVA5djC
X-Proofpoint-ORIG-GUID: pW7kyiSrn8Z6st91FAJGohfO1fVA5djC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_05:2021-04-26,2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104260096
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 23.04.2021 12:08, Vineeth Vijayan wrote:
> The condition to check the cdev pointer validity on
> css_sch_device_unregister() is a leftover from the 'commit c97cd8c81d4a
> ("s390/cio: Remove pm support from ccw bus driver")'. This could lead to a
> situation, where detaching the disk is not happening completely. Remove

This applies to all devices types, not just disks. So replace "disk"
with either "device" or "subchannel".

> this invalid condition in the IO_SCH_UNREG case.
> 
> Fixes: 8cc0dcfdc1c0 ("s390/cio: remove pm support from ccw bus driver")
> Reported-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> Suggested-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>

Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
