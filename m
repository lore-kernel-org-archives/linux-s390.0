Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BAEC43334
	for <linux-s390@archiver.kernel.org>; Mon, 11 Jul 2022 10:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiGKKOq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Jul 2022 06:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbiGKKNe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Jul 2022 06:13:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781907AB0F
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 02:34:07 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26B8BUKc021900;
        Mon, 11 Jul 2022 09:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=0sRZGGAJVmuHLCg1BzNPcKZMZr8WCtQAEZLE7yRSEfM=;
 b=Howp/AfHZX4EpamwDPMU2Fk++xzLOCF1kVgEhyAsblmhw6ao4h67KHUZxMHA7vRk9AGW
 fK2qyIlBRXKt1b+vJlsBSO9rGhBdjU+736Hv/A3Yz1r6DlmWzFvZhZq5fbKm8Amb7fe+
 zSzl/i7dJyGgX5rDYYfRV7rH85pDvvlPUCS+r9djNsi2GdOX1ZnVC7gIXXtmjcGR2Uq4
 xg+/h2WEgZIbXKBNXmNVW0kqu5NJxz+CradciU7ijhVrZRwKd/d7rs0ECmzQACvjJEa+
 0AUqQCy60raMUR1wS7bDbxFy5KNY3Ej0QQS4qFQc55R1A9H/4uoDwxDQ4LOasxQvR6nT ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h84b1wcdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 09:34:05 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26B9RBhL007641;
        Mon, 11 Jul 2022 09:34:05 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h84b1wcdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 09:34:04 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26B9LaWf004311;
        Mon, 11 Jul 2022 09:34:03 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3h71a8hvjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 09:34:03 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26B9Y1nS24707566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 09:34:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF645A4054;
        Mon, 11 Jul 2022 09:34:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA17BA405C;
        Mon, 11 Jul 2022 09:34:00 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 11 Jul 2022 09:34:00 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] trace-cmd: fix writing of uncompressed size
References: <20220711074418.858843-1-svens@linux.ibm.com>
        <CAPpZLN45rz5nTn-XixV_pozdxHQREZymP_Vp8PDQAPXRDwguXA@mail.gmail.com>
        <yt9d35f857ue.fsf@linux.ibm.com>
        <CAPpZLN4LYUs4UrQ7EpAUcsh2qNJnaV9JHZKBJ-RUUkrU_1d73A@mail.gmail.com>
Date:   Mon, 11 Jul 2022 11:34:00 +0200
In-Reply-To: <CAPpZLN4LYUs4UrQ7EpAUcsh2qNJnaV9JHZKBJ-RUUkrU_1d73A@mail.gmail.com>
        (Tzvetomir Stoyanov's message of "Mon, 11 Jul 2022 12:25:08 +0300")
Message-ID: <yt9dy1x03sdz.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IQYJhyvdp2Etq7CQ4ANDwenbZVpibuDF
X-Proofpoint-GUID: kYmKdyLZqxAUj66cmQMxLxKuiJkSMzJe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_15,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=771 phishscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110040
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Tzvetomir Stoyanov <tz.stoyanov@gmail.com> writes:

>> I see that 'handle->pointer' is unsigned long, which is 8 bytes on
>> s390. But it is converted as 4 byte int. That would work on LE
>> platforms, but not on BE.
>
> Yes, that looks like a problem. I think the best fix is to change
> 'handle->pointer' to unsigned int, can you test that on s390? There is
> no need of 8 bytes for that size, unsigned int should be OK. This is
> the size of one data chunk, it should not exceed 4G. Do you want to
> submit such a fix, if it works on s390?

Yes, converting it to unsigned int works. I'll submit a fix.

Thanks!
Sven
