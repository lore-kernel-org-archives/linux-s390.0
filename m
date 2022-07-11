Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89371CCA47B
	for <linux-s390@archiver.kernel.org>; Mon, 11 Jul 2022 09:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiGKJZB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Jul 2022 05:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiGKJYh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Jul 2022 05:24:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C25229C9B
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 02:14:55 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26B8QFQm021422;
        Mon, 11 Jul 2022 09:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=rA9aC+hBTXZJvimIREoNB/cKp78sL0OFNDsIX8ZBgho=;
 b=qi5j6nG1pEqbWB/yeakjQ/bvpUUUcMpin/iCuDXQ5KBFSyTCLOQ3gfbvQvl9eU6IdvxY
 tm214OAUvjrnP7e4aZEjTBzBHsVCGVvEBv8QqCy54fHYSlw9A2zLTOFKZ+v1u0gs8z9M
 bFl8jSofVpNuDGVMTkOmVs3Jzv67W8yJ6Vm76uAaiOAyXYO/3LUSnHkhR0iEQuiRt7Ji
 K031fGCe3u21d0xJMfSobhT6ZucJzqoq2hzOfIn0VNf0HhKS1qMC6+VlM5u83PhHe2st
 in5bWEV+JgZ1kFkXkcdhJwdOkJ7Lta7E+ymHzqr0Y3vrt2vC68rz7CVpqrPx5ImSgNYH Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h84b1w0f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 09:14:54 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26B8sVhT025540;
        Mon, 11 Jul 2022 09:14:53 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h84b1w0ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 09:14:53 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26B9850x007674;
        Mon, 11 Jul 2022 09:14:52 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3h70xhtgfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 09:14:51 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26B9EnUY15729136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 09:14:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C9A442045;
        Mon, 11 Jul 2022 09:14:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76A6942042;
        Mon, 11 Jul 2022 09:14:49 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 11 Jul 2022 09:14:49 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] trace-cmd: fix writing of uncompressed size
References: <20220711074418.858843-1-svens@linux.ibm.com>
        <CAPpZLN45rz5nTn-XixV_pozdxHQREZymP_Vp8PDQAPXRDwguXA@mail.gmail.com>
Date:   Mon, 11 Jul 2022 11:14:49 +0200
In-Reply-To: <CAPpZLN45rz5nTn-XixV_pozdxHQREZymP_Vp8PDQAPXRDwguXA@mail.gmail.com>
        (Tzvetomir Stoyanov's message of "Mon, 11 Jul 2022 11:55:34 +0300")
Message-ID: <yt9d35f857ue.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _kZpl7SbWt5-9HKSDHvt5B1MB8wtwzXa
X-Proofpoint-GUID: 8oQWcrZU2PAQv-kfHtClBuyWPgmfEwFR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_15,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110039
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

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
>
>>
>> Fixes: 3f8447b1 ("trace-cmd library: Add support for compression algorithms")
>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>> ---
>>  lib/trace-cmd/trace-compress.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/trace-cmd/trace-compress.c b/lib/trace-cmd/trace-compress.c
>> index a63295e..ad9b7fc 100644
>> --- a/lib/trace-cmd/trace-compress.c
>> +++ b/lib/trace-cmd/trace-compress.c
>> @@ -331,7 +331,7 @@ int tracecmd_compress_block(struct tracecmd_compression *handle)
>>                 goto out;
>>
>>         /* Write uncompressed data size */
>> -       endian4 = tep_read_number(handle->tep, &handle->pointer, 4);
>> +       endian4 = tep_read_number(handle->tep, &size, 4);
>
> Here 'size' is the size of the buffer, used by the compression
> algorithm to compress the data block. That size depends on the
> algorithm, but usually it is less than the uncompressed data size and
> bigger than the compressed data size. On this position in the file
> must be written the size of the uncompressed data, that is
> 'handle->pointer'. I agree that the name is a bit misleading, as this
> is not a pointer to a memory address.  The 'handle->pointer' is the
> offset within the compression buffer, where the next uncompressed data
> will be written. The logic uses a dynamic buffer with given capacity.
> When the buffer is empty, 'handle->pointer' is 0. With each
> uncompressed data chunk, written into that buffer, 'handle->pointer'
> increases with its size - i.e. the first byte is written on position 0
> (the initial 'handle->pointer') and the pointer increases to 1. That's
> why it reflects the size of the uncompressed data. When the pointer
> reaches the capacity of the buffer, the buffer is extended. At the
> end, that buffer is passed to the compression algorithm, to compress
> the block.

I see that 'handle->pointer' is unsigned long, which is 8 bytes on
s390. But it is converted as 4 byte int. That would work on LE
platforms, but not on BE.
