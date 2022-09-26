Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B481BC32771
	for <linux-s390@archiver.kernel.org>; Mon, 26 Sep 2022 16:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiIZQrU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 26 Sep 2022 12:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiIZQqj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 26 Sep 2022 12:46:39 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD52BB1
        for <linux-s390@vger.kernel.org>; Mon, 26 Sep 2022 08:37:50 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QEa7f1004943;
        Mon, 26 Sep 2022 15:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=O2xn9IAc0c1I6U0hHLQfA9OJXarWryZCpk2Q32o5lcY=;
 b=CZbdCH93aXVcNK/gf2PZ79bw33tPd76o22cO6fFi1VmuoKf/N5FBNRDSuHEDtQOeSsx9
 1P9YE4eATcfF1kWEFUHgCdW6WFeADPXYNZsi9f3c8oXmvl87r8cT0m+UEqtcVToBC+Ww
 iduzyAjX3XWvkOngAuGyRhnECmVeIfC6Y0K97W7RlZLwLbHA1jobWFdPHWhRB5rRU4LB
 8vVQC6ANDG1e73I8ceIujav1SpVOQ1Z/oLqYr8LbuZgN2NZv06R+XLHXotQBoZTRg42u
 ns9FZ+P96dIHpexIER8MBqv7n0Fop9QvX5fIoexoxPi1bcFtJw5+lummzYshzmDr2o4K lg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jucjrde3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 15:37:46 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28QFZqrB012804;
        Mon, 26 Sep 2022 15:37:44 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3juapug9yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 15:37:44 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28QFbfpt42140062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 15:37:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B4B74C046;
        Mon, 26 Sep 2022 15:37:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F2F04C044;
        Mon, 26 Sep 2022 15:37:41 +0000 (GMT)
Received: from [9.171.90.72] (unknown [9.171.90.72])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 26 Sep 2022 15:37:41 +0000 (GMT)
Message-ID: <0960f728-9785-ef1c-dd2d-67338bd65047@linux.ibm.com>
Date:   Mon, 26 Sep 2022 17:37:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: RFC: dasd: use blk_mq_alloc_disk
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     hoeppner@linux.ibm.com, linux-s390@vger.kernel.org
References: <20220721133251.1878402-1-hch@lst.de>
 <668f8eba-6e60-fa4c-99dd-ed07cdc46ea3@linux.ibm.com>
 <20220923154419.GA22651@lst.de>
From:   Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20220923154419.GA22651@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pOxrnaL6e4FL2sLhUvwDnZnsufOeJ9MT
X-Proofpoint-ORIG-GUID: pOxrnaL6e4FL2sLhUvwDnZnsufOeJ9MT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_08,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=915 impostorscore=0 clxscore=1015 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260098
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Am 23.09.22 um 17:44 schrieb Christoph Hellwig:
> On Fri, Sep 23, 2022 at 05:42:10PM +0200, Stefan Haberland wrote:
>> I have tested it on s390 and reviewed the code. Looks good to me.
>>
>> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
>>
>> Would you like to send it to Jens directly or should I take it?
> I think it would be best if you could send it on.  Thanks!

applied, thanks.

