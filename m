Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6D4C433EF
	for <linux-s390@archiver.kernel.org>; Wed, 17 Nov 2021 09:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8427563212
	for <linux-s390@archiver.kernel.org>; Wed, 17 Nov 2021 09:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhKQJQD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:16:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232252AbhKQJQD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Nov 2021 04:16:03 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AH8HouU018876;
        Wed, 17 Nov 2021 09:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=6XzZIc/tFaw6oUBWOWjsPIy66vbATHtnPKK7dLoPQbg=;
 b=PrEPp0RP0re5mlYDZzhtyYp4scNGp3/HiW9sAV8fWBomZJPsYyQmnJ6kWvssKnpMmSDY
 tXbkDfGYjVeXuNvv8y4j87zdk3FTTv+th20Df6ocaZhF6qZTlt1FcJyO90NHXkb3MMik
 bVIC+jSKX8bmeYBjLaEe7B+DyGx8fOZVFfqID47QUuaE76gg5w7clGigKCELAtlFgOTx
 It/my7e4thlYu13HFONdheGU6DNf/G62iKiT21AH30cAEat2FPx7ZdfN+avnnMSkZDS4
 KzUbTmrJJ7/N0zPjDN5GvahJK7hFGsU1aeXJstqTKOjaIuu9fhx9XgDi4dYOxYYwNd7y YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ccx3tgy6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 09:12:48 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AH90ECB009345;
        Wed, 17 Nov 2021 09:12:48 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ccx3tgy66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 09:12:47 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AH93Bme006169;
        Wed, 17 Nov 2021 09:12:45 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3ca50a7u0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 09:12:45 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AH9Chv030671128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 09:12:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15C8711C05B;
        Wed, 17 Nov 2021 09:12:43 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D099E11C054;
        Wed, 17 Nov 2021 09:12:42 +0000 (GMT)
Received: from osiris (unknown [9.145.92.52])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 17 Nov 2021 09:12:42 +0000 (GMT)
Date:   Wed, 17 Nov 2021 10:12:41 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 2/2] ftrace/samples: add s390 support for ftrace direct
 multi sample
Message-ID: <YZTHiTfC/CPmg1f9@osiris>
References: <20211115195614.3173346-1-hca@linux.ibm.com>
 <20211115195614.3173346-3-hca@linux.ibm.com>
 <20211116174430.159c89c7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116174430.159c89c7@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9zUvviisBg0RC8CgNv3CD1J7YFG4xUFH
X-Proofpoint-ORIG-GUID: RsMphQ3sSsuMKbf_8GuhYYmz7JIjmfnU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_03,2021-11-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=935
 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111170045
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Nov 16, 2021 at 05:44:30PM -0500, Steven Rostedt wrote:
> On Mon, 15 Nov 2021 20:56:14 +0100
> Heiko Carstens <hca@linux.ibm.com> wrote:
> 
> I know this is for your tree, but you really should never have an empty
> change log. I could think of many things to say here.
> 
> The only acceptable empty change log IMHO is spelling fixes.

I don't think there is much of a disagreement here, except me being
lazy. I'll add a couple of words.
