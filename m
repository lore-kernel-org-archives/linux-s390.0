Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83533C4320A
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 17:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6675C610C7
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 17:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhHWRiu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:38:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231612AbhHWRiu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Aug 2021 13:38:50 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17NHZFWN155378;
        Mon, 23 Aug 2021 13:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=BCaJjgu8Xenr1k3l+X+usCTY/EzixwtI9TAn345gKPk=;
 b=NZXraqmb4SkdX5CilKp9saG35RTzgWVwvGdGpxcfE9SPqHNSCxXOmTFKsEJJHOvmD/LK
 iBAbnMCMccPl59Xi5rn3Men4UUTxILg1RiJBHrKYRPiobxAqbzWO2DnaVMSsa1snxjZ+
 yn2Atu/EEmd+NwVfyMdceLlVwX9KWwJvaneRjLXRXAL1VCIC8E3CBXiNYn2xak6ln/NP
 M1kZrjaNRQytKZcul5u0CNk5SaeY8KhA52A+/6rWQmQ2b1Voezn7IE58NlR1ZsiuLhhA
 kUsY95UGad7SmZ3pqZAaMvQSV3hWA4db8cwCSVZV8nvDO+gR/iONCsmvFybwZbM76ZjG kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3akejb4yqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 13:38:05 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17NHaBU4164595;
        Mon, 23 Aug 2021 13:38:04 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3akejb4yps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 13:38:04 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17NHbtAC008266;
        Mon, 23 Aug 2021 17:38:03 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3ajs48b5kj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 17:38:02 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17NHYKxF46399978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 17:34:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F79E42041;
        Mon, 23 Aug 2021 17:37:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14A7A42067;
        Mon, 23 Aug 2021 17:37:59 +0000 (GMT)
Received: from osiris (unknown [9.145.169.88])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 23 Aug 2021 17:37:59 +0000 (GMT)
Date:   Mon, 23 Aug 2021 19:37:57 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     CGEL <cgel.zte@gmail.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] s390:raw3270: Convert sysfs sprintf/snprintf
 family to sysfs_emit
Message-ID: <YSPc9Yqn3xsioLwU@osiris>
References: <20210821035358.28350-1-jing.yangyang@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210821035358.28350-1-jing.yangyang@zte.com.cn>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1lLdl75k9LctcdG4J75VP77gPa7MmkXX
X-Proofpoint-ORIG-GUID: gjNEUgErf9x1C5Wj17vyPsAs5Eig52wq
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-23_04:2021-08-23,2021-08-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 clxscore=1011 mlxlogscore=999 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108230120
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Aug 20, 2021 at 08:53:58PM -0700, CGEL wrote:
> From: jing yangyang <jing.yangyang@zte.com.cn>
> 
> Fix the following coccicheck warning:
> ./drivers/s390/char/raw3270.c:1066:8-16: WARNING: use scnprintf or sprintf
> ./drivers/s390/char/raw3270.c:1050:8-16: WARNING:use scnprintf or sprintf
> ./drivers/s390/char/raw3270.c:1058:8-16: WARNING:use scnprintf or sprintf
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
...
>  static ssize_t
>  raw3270_model_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> -	return snprintf(buf, PAGE_SIZE, "%i\n",
> +	return sysfs_emit(buf, "%i\n",
>  			((struct raw3270 *) dev_get_drvdata(dev))->model);

Identation of the line following the patched line is now incorrect.
Also the sign-off chain is not correct - I also doubt that "CGEL" is a
person, but what do I know.

Not applied.
