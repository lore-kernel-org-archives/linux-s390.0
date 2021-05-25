Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD801C2B9F8
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 12:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA4D61284
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 12:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhEYMOC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 May 2021 08:14:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231865AbhEYMOC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 May 2021 08:14:02 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PC4w2M106064
        for <linux-s390@vger.kernel.org>; Tue, 25 May 2021 08:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=qPg5Ds5cof+CuLUMsxyJktNs2ecbfIi1erMyfrL8Dfc=;
 b=NSBpeYcWSPaaWLbQ67CWm7Jf3vSXyvgUWpa1nYxHg1jFgJpCfpUjIT6h6T0apTtaSN4M
 1nq3bdUtLiboD+FDPMMCUht4rA3UdukwEzprjcFKdiSWUyQ57I+McbqootR0IPrzt63S
 tFLXbgaFp+ATEDhAaas9DeESSXYZt/8gS2hrz0ELdZ2G/jmtwv4SutgGNy+P83ODFxW7
 2Zu3FX6iGfe46yGh2twlM8TK9iF9lSGxRkLSo+jyAegokgIlWO34EOqZvKh+qTkahJfA
 Ao63VIEq2JV0PT5PBrKFMRv/Zxbn5rjQKvGOlmvni3ddi2A4tOhuKA5Zg7A8WvJHChFM Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38rxvmc6mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 25 May 2021 08:12:32 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14PC55WX106804
        for <linux-s390@vger.kernel.org>; Tue, 25 May 2021 08:12:31 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38rxvmc6jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 08:12:31 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14PBq1oY023865;
        Tue, 25 May 2021 12:12:29 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 38ps7h9a6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 12:12:29 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14PCBv4T24838584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 12:11:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B796C11C05E;
        Tue, 25 May 2021 12:12:26 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B57A11C05C;
        Tue, 25 May 2021 12:12:26 +0000 (GMT)
Received: from localhost (unknown [9.171.17.66])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 25 May 2021 12:12:26 +0000 (GMT)
Date:   Tue, 25 May 2021 14:12:25 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Alexander Egorenkov <egorenar@linux.ibm.com>
Cc:     Fabrice Fontaine <fontaine.fabrice@gmail.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] arch/s390: disable SSP when needed
Message-ID: <your-ad-here.call-01621944745-ext-0740@work.hours>
References: <20210510053133.1220167-1-fontaine.fabrice@gmail.com>
 <87y2c3nsku.fsf@oc8242746057.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y2c3nsku.fsf@oc8242746057.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A0pQ-odSPmOZo5X6DkoKRlNUOdm_6crs
X-Proofpoint-ORIG-GUID: XElSD8AaY6SVefqraoKr8WEoKx5NCqNX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_06:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=672
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250074
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 25, 2021 at 10:08:49AM +0200, Alexander Egorenkov wrote:
> Hi Fabrice,
> 
> the patch looks good to me.
> Thank you.
> 
> Reviewed-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> Tested-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Applied, thanks
