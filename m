Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C675C6FA82
	for <linux-s390@archiver.kernel.org>; Tue, 20 Sep 2022 19:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiITT3A (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Sep 2022 15:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiITT27 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Sep 2022 15:28:59 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA38851A11
        for <linux-s390@vger.kernel.org>; Tue, 20 Sep 2022 12:28:58 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KIxCxQ001499;
        Tue, 20 Sep 2022 19:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+XHJtcbXRdg9MLh0HYsX+cQkFvM4ckj3F07+wHsaXX0=;
 b=LXtDtCQn16AC/yzQiVZBcD71LG4NJHvAfNdZ3J8lLXw9NKtb8P4LbOdsRR3qHQ/h3SEG
 uR8dvM8jyhH48TwJ5Bc7OheYfV0H8WdXO1ZZNrc6p2semHFmFYkl32TDk2rutppw2mgU
 Pw0lHtiTiDLa9hmkKMNd3xtDw2AxDEz4BOIbMIJP+AoVjLMqw4hn+oj9/oQRCYRI1O5N
 +xCE1BSf6ChThtaM1JjEsEiYk4l7z5iAVaSwgeJaVmnXnW1zEIvN8RcuIvXlKTqyBRMd
 eSP8CjsKBWRAumGPnARj8/dX3zyG/pZU/0Eql9THm1oR/dSk43obNAnakR892rXQ9Nvn Gw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jqk9e0vsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 19:28:55 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28KJLwFe017453;
        Tue, 20 Sep 2022 19:28:54 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3jn5v949a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 19:28:53 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28KJSoB135651952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 19:28:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7B25A404D;
        Tue, 20 Sep 2022 19:28:50 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85BB0A4040;
        Tue, 20 Sep 2022 19:28:49 +0000 (GMT)
Received: from [9.211.146.75] (unknown [9.211.146.75])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Sep 2022 19:28:49 +0000 (GMT)
Message-ID: <ce497572-330f-e5d4-b6e7-a10ad9f0826b@linux.ibm.com>
Date:   Tue, 20 Sep 2022 21:28:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: RFC: dasd: use blk_mq_alloc_disk
To:     Christoph Hellwig <hch@lst.de>
Cc:     hoeppner@linux.ibm.com, linux-s390@vger.kernel.org
References: <20220721133251.1878402-1-hch@lst.de>
 <244e66a5-2a81-2275-e97d-ebe3186ccebb@linux.ibm.com>
 <20220920072755.GA18172@lst.de>
Content-Language: en-US
From:   Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20220920072755.GA18172@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YWDbq-bCIdJVJHe6RS3wlwsgPgT7vHKP
X-Proofpoint-ORIG-GUID: YWDbq-bCIdJVJHe6RS3wlwsgPgT7vHKP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_08,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 clxscore=1015 mlxlogscore=503
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200114
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Am 20.09.22 um 03:27 schrieb Christoph Hellwig:
> On Tue, Jul 26, 2022 at 12:58:16PM +0200, Stefan Haberland wrote:
>> Am 21.07.22 um 15:32 schrieb Christoph Hellwig:
>>> As far as I can tell there is no need for the staged setup in
>>> dasd, so allocate the tagset and the disk with the queue in
>>> dasd_gendisk_alloc.
>>>
>>> Warning: untested due to a lack of hardware.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Thanks for the patch. From a first quick look it looks reasonable.
>> I will give it a try on my test machine.
> Did you get a chance to look into it?

Hi Christoph,

unfortunately not. Sorry. I will have a closer look soon.

