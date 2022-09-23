Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9951ECAAD8
	for <linux-s390@archiver.kernel.org>; Fri, 23 Sep 2022 15:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiIWPnU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Sep 2022 11:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiIWPmx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 23 Sep 2022 11:42:53 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F20147A32
        for <linux-s390@vger.kernel.org>; Fri, 23 Sep 2022 08:42:21 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NFBGWE012843;
        Fri, 23 Sep 2022 15:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : references : from : subject : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vLJURMDwHEM/dsVYl/iXpRdDI1C7aohuPPWMRXvTv0Q=;
 b=mdtla6aoKgfwnF/5rR12/ssD2HVGJpB1L0fxRJd/MQPFTwgD59C2KO1S3KRVZk1ZXtSa
 t8ajRa+kl+xpdwcaNNsHQ2bIrKGcGWX6N2EeJQJTk+kp7zfJZ9g/2h+G6pgAIW+5eVpR
 4B0Wz2wYquGWgnCj8JdEnT26nbuZwiKme0SwYZnrha4t9JIekoPoEd2i3yL4EP/08iyJ
 bjhTijDqVppgffutMfq4ELt4AHvzvk+xSzj3Aumq9S0jBIJKC4mIUf408O4h6nj1gswG
 S23Jqq1OC7Gn5jNGGEkHg2NC6blK01k9n0QHoPSdGs5XjqpQSsM3Z3sOss2rou0EE8mi lQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3js99tbtv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 15:42:17 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28NFZmHR002635;
        Fri, 23 Sep 2022 15:42:16 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3jn5ghp3xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 15:42:15 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28NFgCAE27066738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 15:42:12 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E0284C046;
        Fri, 23 Sep 2022 15:42:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 859574C040;
        Fri, 23 Sep 2022 15:42:11 +0000 (GMT)
Received: from [9.77.155.178] (unknown [9.77.155.178])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 23 Sep 2022 15:42:11 +0000 (GMT)
Message-ID: <668f8eba-6e60-fa4c-99dd-ed07cdc46ea3@linux.ibm.com>
Date:   Fri, 23 Sep 2022 17:42:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
To:     Christoph Hellwig <hch@lst.de>, hoeppner@linux.ibm.com
Cc:     linux-s390@vger.kernel.org
References: <20220721133251.1878402-1-hch@lst.de>
Content-Language: en-US
From:   Stefan Haberland <sth@linux.ibm.com>
Subject: Re: RFC: dasd: use blk_mq_alloc_disk
In-Reply-To: <20220721133251.1878402-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vhJcAzRzdZLMxAbMdUWcefjTakSNgWhF
X-Proofpoint-GUID: vhJcAzRzdZLMxAbMdUWcefjTakSNgWhF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_04,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 spamscore=0 mlxlogscore=777
 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230101
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Am 21.07.22 um 15:32 schrieb Christoph Hellwig:
> As far as I can tell there is no need for the staged setup in
> dasd, so allocate the tagset and the disk with the queue in
> dasd_gendisk_alloc.
>
> Warning: untested due to a lack of hardware.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Thanks for the patch.
I have tested it on s390 and reviewed the code. Looks good to me.

Reviewed-by: Stefan Haberland <sth@linux.ibm.com>

Would you like to send it to Jens directly or should I take it?

