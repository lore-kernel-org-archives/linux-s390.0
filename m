Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4249EC432BE
	for <linux-s390@archiver.kernel.org>; Tue, 31 Aug 2021 07:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1364E60F9E
	for <linux-s390@archiver.kernel.org>; Tue, 31 Aug 2021 07:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbhHaHK0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 31 Aug 2021 03:10:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232209AbhHaHKZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 31 Aug 2021 03:10:25 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17V736ti047385;
        Tue, 31 Aug 2021 03:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=A4or8wCPaJw5nsvcratCIQfzxHr6UWtP9FgQXgaGPn4=;
 b=AEUVeRmL4rBm830wgqsOM98obFTq92/4GFOKRqdG6IaQ3fIkJTd28eL87XodnTQKVrMP
 MIe8HGXP9wHctKtDUD5tPMZgpNpQjf6fRXNpA5iHxTeH66W0sq39XJcWSKUDrXz7WIZU
 P9sg/jRDjZaDEKcMCU6sFqyzVjwrwQtuOMjOz61QIL/+spL9KL/cWUNROreuVGQlE4dD
 LL77R2Js9RTO94hEvrdarCgDiGvebLW1mMv/MYqcdVFeKhzjT8f5+xLzeTsStypuX7fg
 fO4xiweq0Kh+LfDrHtu5Ksvqk6zDIOfFzimO1B4peolRyDmrFkZu+Rfo0wW1AX5Thyp8 Sw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ases01rsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 03:09:19 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17V73WCf020122;
        Tue, 31 Aug 2021 07:09:16 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3aqcdj50gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 07:09:16 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17V75CZO55181748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 07:05:12 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FCEC4C059;
        Tue, 31 Aug 2021 07:09:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31E3D4C04A;
        Tue, 31 Aug 2021 07:09:11 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.164.122])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 31 Aug 2021 07:09:11 +0000 (GMT)
Subject: Re: [GIT PULL] s390 updates for 5.15 merge window
To:     Nathan Chancellor <nathan@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        qemu-s390x <qemu-s390x@nongnu.org>
References: <YSzZFgBt6nMvpVgc@osiris>
 <YS2RrUma2oOSYtIc@Ryzen-9-3900X.localdomain>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <82161448-2770-158c-fdd3-d253b4ae476f@de.ibm.com>
Date:   Tue, 31 Aug 2021 09:09:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YS2RrUma2oOSYtIc@Ryzen-9-3900X.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: t2nwNVzhx5q_ZLHD7RIrXIkEYm8lA_r4
X-Proofpoint-ORIG-GUID: t2nwNVzhx5q_ZLHD7RIrXIkEYm8lA_r4
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_03:2021-08-30,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310041
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 31.08.21 04:19, Nathan Chancellor wrote:
> Hi Heiko,
> 
> On Mon, Aug 30, 2021 at 03:11:50PM +0200, Heiko Carstens wrote:
>> - Enable KCSAN for s390. This comes with a small common code change to fix a
>>    compile warning. Acked by Marco Elver:
>>    https://lore.kernel.org/r/20210729142811.1309391-1-hca@linux.ibm.com/
> 
> This caught my eye, as we are boot testing KCSAN + KCSAN_KUNIT_TEST in
> our CI [1] for x86_64 so it would be nice to enable this for s390 as
> well. However, it does not seem like the unit tests pass when booting up
> in QEMU, is this expected or am I doing something wrong? The results and
> compiler versions are below (the results are the same), they should both
> have the commits that are mentioned in the KCSAN message.

Do you have a branch somewhere where you have the s390 build rules as well as
the qemu command line? Maybe its a QEMU TCG issue, dont know. CC qemu-s390x
just in case.

FWIW, if you want access to a virtual s390x let me know.

> 
> GCC 12.0.0 @ d904008df267cbcc01bd6edf98fa0789fb6e94da
> 
> [  131.813482]     not ok 1 - test_basic
> [  135.321137]     not ok 2 - test_concurrent_races
> [  138.830648]     ok 3 - test_novalue_change
> [  142.342562]     not ok 4 - test_novalue_change_exception
> [  145.851008]     not ok 5 - test_unknown_origin
> [  149.361416]     ok 6 - test_write_write_assume_atomic
> [  152.872013]     not ok 7 - test_write_write_struct
> [  156.382960]     not ok 8 - test_write_write_struct_part
> [  159.890222]     ok 9 - test_read_atomic_write_atomic
> [  163.402919]     not ok 10 - test_read_plain_atomic_write
> [  166.912931]     not ok 11 - test_read_plain_atomic_rmw
> [  170.431915]     not ok 12 - test_zero_size_access
> [  173.940959]     ok 13 - test_data_race
> [  177.452028]     not ok 14 - test_assert_exclusive_writer
> [  180.962840]     not ok 15 - test_assert_exclusive_access
> [  184.474686]     not ok 16 - test_assert_exclusive_access_writer
> [  187.992282]     not ok 17 - test_assert_exclusive_bits_change
> [  191.501869]     ok 18 - test_assert_exclusive_bits_nochange
> [  195.013138]     not ok 19 - test_assert_exclusive_writer_scoped
> [  199.534212]     not ok 20 - test_assert_exclusive_access_scoped
> [  203.053361]     ok 21 - test_jiffies_noreport
> [  206.573803]     ok 22 - test_seqlock_noreport
> [  210.093508]     ok 23 - test_atomic_builtins
> [  210.094014] not ok 1 - kcsan
> 
> clang 14.0.0 @ 657bb7262d4a53e903e702d46fdcab57b7085128:
> 
> [   10.341427]     not ok 1 - test_basic
> [   13.848960]     not ok 2 - test_concurrent_races
> [   17.359671]     ok 3 - test_novalue_change
> [   20.869202]     not ok 4 - test_novalue_change_exception
> [   24.379067]     not ok 5 - test_unknown_origin
> [   27.889492]     ok 6 - test_write_write_assume_atomic
> [   31.399572]     not ok 7 - test_write_write_struct
> [   34.910833]     not ok 8 - test_write_write_struct_part
> [   38.419473]     ok 9 - test_read_atomic_write_atomic
> [   41.929642]     not ok 10 - test_read_plain_atomic_write
> [   45.439644]     not ok 11 - test_read_plain_atomic_rmw
> [   48.950048]     not ok 12 - test_zero_size_access
> [   52.459026]     ok 13 - test_data_race
> [   55.969806]     not ok 14 - test_assert_exclusive_writer
> [   59.480436]     not ok 15 - test_assert_exclusive_access
> [   62.990164]     not ok 16 - test_assert_exclusive_access_writer
> [   66.499199]     not ok 17 - test_assert_exclusive_bits_change
> [   70.009481]     ok 18 - test_assert_exclusive_bits_nochange
> [   73.522184]     not ok 19 - test_assert_exclusive_writer_scoped
> [   78.030448]     not ok 20 - test_assert_exclusive_access_scoped
> [   81.539059]     ok 21 - test_jiffies_noreport
> [   85.051769]     ok 22 - test_seqlock_noreport
> [   88.572048]     ok 23 - test_atomic_builtins
> [   88.572279] not ok 1 - kcsan
> 
> [1]: https://github.com/ClangBuiltLinux/continuous-integration2
> 
> Cheers,
> Nathan
> 
