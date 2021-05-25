Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ABCC2B9F8
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 08:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0066B6135F
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 08:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhEYIMc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 May 2021 04:12:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232255AbhEYIK1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 May 2021 04:10:27 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14P84HEE128628
        for <linux-s390@vger.kernel.org>; Tue, 25 May 2021 04:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : cc :
 subject : in-reply-to : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=vASpDwY11cpVNOitMOfCDh5Av5WBXVGqZiEWopTrAok=;
 b=KPrz/Qx9sfnZgrtRyGAolfJXcp6QMm8f3J7kAcBmZ0lywX3riVf3+3uLKzgRT6i+Ihw6
 3sc4HjYw+wLGpfKArsV3YMyOywhTvFra9uPxgNMIr+UszjN4LuBz1/50zfVtmevo4+xS
 RJEzNRSJfjREu+7f2WvBqk8rU9xvf4z6iDCI+iQks4SkIDlCBMR31RJrolxZMgxE2DMF
 oxRCIwD5ST/XgzsESabL09HVbTnAVwx+VVH85cap+QDlfNOL59to4oDRN0RD6kCZcBn1
 FMsDwic5sM5qWN7CmhbECYWtBaNBU5I8dVGUciaZeDTPbswDBheJjTORDCGUhafpPlHT jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38rw7ggfsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 25 May 2021 04:08:55 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14P84ibh130775
        for <linux-s390@vger.kernel.org>; Tue, 25 May 2021 04:08:55 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38rw7ggfrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 04:08:55 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14P7v4t5028198;
        Tue, 25 May 2021 08:08:53 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 38psk8960p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 08:08:53 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14P88L8U32964940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 08:08:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 535AC5204E;
        Tue, 25 May 2021 08:08:50 +0000 (GMT)
Received: from oc8242746057.ibm.com (unknown [9.171.79.73])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 23DD652052;
        Tue, 25 May 2021 08:08:50 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     Fabrice Fontaine <fontaine.fabrice@gmail.com>
Cc:     linux-s390@vger.kernel.org, fontaine.fabrice@gmail.com
Subject: Re: [PATCH] arch/s390: disable SSP when needed
In-Reply-To: <20210510053133.1220167-1-fontaine.fabrice@gmail.com> (message
 from Fabrice Fontaine on Mon, 10 May 2021 07:31:33 +0200)
In-Reply-To: 
Date:   Tue, 25 May 2021 10:08:49 +0200
Message-ID: <87y2c3nsku.fsf@oc8242746057.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9ttFpxLVNv6EVeCO2aLZ--mk7WjnGFLU
X-Proofpoint-ORIG-GUID: uW5gMCcbSzoAbwPYg8vbaIHtX54xEam1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_05:2021-05-24,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0 mlxlogscore=605
 mlxscore=0 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250056
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Fabrice,

the patch looks good to me.
Thank you.

Reviewed-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Tested-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Regards
Alex
