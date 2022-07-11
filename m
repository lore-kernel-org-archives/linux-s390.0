Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66364C433EF
	for <linux-s390@archiver.kernel.org>; Mon, 11 Jul 2022 09:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiGKJGy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Jul 2022 05:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiGKJGw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Jul 2022 05:06:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460C32251E
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 02:06:51 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26B8QiPD001191;
        Mon, 11 Jul 2022 09:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=sdUrg3d133WsYgF14QRw9Si78ETK9vMj6eDQX2xNbJU=;
 b=c+uX1vT9Uijbh0AHNJTjMAN8C/PF5nYBF0FWScwHjqyAxrwtPz8Sk77JJB5y71oCKLjy
 B3XAVk7SZa1cwfAJzo1lSIvQLX1HtjjuH0JcNukj5ppjX546MKpYMEvSSdPR2ux/BNyJ
 shXnC4GdWdfMlv5mASKWnjNPo+tA9QphQRWX5M9glFHWx+KydjstpoIpWyDQ2josi1FQ
 Qh6djKXLyh+eXpq8cKoSrIdgBB1Fe01GNu1TA52AZX4+LTYOTGJMN5NebMdTEchNDERx
 ESKT4mFIhPJs/SKdsR0Ms4c2TvceXKHZCEBodjylvqpEKIAhMhVIWqEG17AtTlnc5nr/ /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h83whn89r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 09:06:49 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26B90ek0008965;
        Mon, 11 Jul 2022 09:06:49 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h83whn88v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 09:06:48 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26B96CEx023268;
        Mon, 11 Jul 2022 09:06:46 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3h71a8tf9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 09:06:46 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26B96sco32178586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 09:06:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D4AC11C04C;
        Mon, 11 Jul 2022 09:06:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23FC111C04A;
        Mon, 11 Jul 2022 09:06:44 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 11 Jul 2022 09:06:44 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] trace-cmd: fix writing of uncompressed size
In-Reply-To: <CAPpZLN45rz5nTn-XixV_pozdxHQREZymP_Vp8PDQAPXRDwguXA@mail.gmail.com>
        (Tzvetomir Stoyanov's message of "Mon, 11 Jul 2022 11:55:34 +0300")
References: <20220711074418.858843-1-svens@linux.ibm.com>
        <CAPpZLN45rz5nTn-XixV_pozdxHQREZymP_Vp8PDQAPXRDwguXA@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Date:   Mon, 11 Jul 2022 11:06:35 +0200
Message-ID: <yt9da69g5884.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CEdaThEYO8SOcnYt-RBwGhN-WjPEOs6H
X-Proofpoint-ORIG-GUID: zd6u58MRxHIw-CMZVQPL9la1A-obvLcR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_13,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=993 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110036
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi,

Tzvetomir Stoyanov <tz.stoyanov@gmail.com> writes:

> On Mon, Jul 11, 2022 at 10:44 AM Sven Schnelle <svens@linux.ibm.com> wrote:
>>
>> Pass &size instead of &handle->pointer. Interestingly this doesn't hurt
>> on x86, but makes trace-cmd fail on s390.
>
> Hi Sven,
> Thanks for testing this code on s390, I've tested it only on x86.
> Please, can you give more information about the trace-cmd failure on
> s390?

I'm running:

# trace-cmd record -p function -F /bin/ls
  plugin 'function'
[ls output follows]
CPU22 data recorded at offset=0x154000
    115345 bytes in size (1269760 uncompressed)
[skipped other CPUs, they didn't record anything]

trace-cmd report doesn't show any trace:

# trace-cmd report
version = 7

trace-cmd dump says:

# trace-cmd dump
 Tracing meta data in file trace.dat:
        [Initial format]
                7       [Version]
                1       [Big endian]
                8       [Bytes in a long]
                4096    [Page size, bytes]
                zstd    [Compression algorithm]
                1.5.2   [Compression version]
        [buffer "", "local" clock, 4096 page size, 1 cpus, 115345 bytes flyrecord data]
        [142 options]
trace-cmd: Unknown error -22
  cannot uncompress section block

Thanks,
Sven
