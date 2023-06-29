Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B1DEB64D9
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jun 2023 08:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjF2IH7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Jun 2023 04:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjF2IHa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 29 Jun 2023 04:07:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF01E5253;
        Thu, 29 Jun 2023 00:59:40 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T7kldJ025415;
        Thu, 29 Jun 2023 07:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=s+WHj7KtXMkj7J2taiGcgx8uAykZlRdNfTv1hCqfDDM=;
 b=gWFYj1i/F6wk/XHgOzz5GN1wSqBbC2UHr9SkzR0S0eL2gOwtqJ0kUvE38VlbF/9D2H3B
 Rn6VaqAwkAmX/+rU0VBB6bllTQFW+ugqcVQwCrT3imaYYTTRrUu4BFpvwsKi3ojjoqHg
 MBzSkvdvO/8ApHPDSMrsrHmMFemtHZuxdsSaCxVxLDwVYFuItAZXzQhlLYySnQUeDG3v
 pIBkFHTk5NA9tjcasadMdRb5H7BKdEiGWP0VRqjw1Mlsa1pdaz+tDZki7h2O0+rH6wHI
 EjLJQs0oIVZ1/t2Rv7y9W8jNuQ5gUWnJMW/Nvy/Kjn9uWf6cyfAoTDIOpVm2p8fhlEpO LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rh5v4g822-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 07:59:22 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35T7l1S7025980;
        Thu, 29 Jun 2023 07:59:22 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rh5v4g818-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 07:59:22 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35T28sqC023337;
        Thu, 29 Jun 2023 07:59:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3rdr452d3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 07:59:20 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35T7xGxB40895066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 07:59:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79C0920043;
        Thu, 29 Jun 2023 07:59:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB25720040;
        Thu, 29 Jun 2023 07:59:15 +0000 (GMT)
Received: from [9.171.10.251] (unknown [9.171.10.251])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 29 Jun 2023 07:59:15 +0000 (GMT)
Message-ID: <c589f29d-5ce5-9fc2-1a2d-3e5181a14bdd@linux.ibm.com>
Date:   Thu, 29 Jun 2023 09:59:15 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] s390/lcs: Remove FDDI option
Content-Language: en-US
To:     Simon Horman <simon.horman@corigine.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
References: <20230628135736.13339-1-wintera@linux.ibm.com>
 <ZJyT1aWFGqHjxofQ@corigine.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <ZJyT1aWFGqHjxofQ@corigine.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pBa_oyxnma8jlVeMNBGAHR7_d2ZqLc7i
X-Proofpoint-ORIG-GUID: fZz0xX2PQ--4Mgr1AwV-mL42OT6947mi
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=508 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290066
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 28.06.23 22:11, Simon Horman wrote:
> [text from Jakub]
> 
> ## Form letter - net-next-closed
> 
> The merge window for v6.5 has begun and therefore net-next is closed
> for new drivers, features, code refactoring and optimizations.
> We are currently accepting bug fixes only.
> 
> Please repost when net-next reopens after July 10th.
> 
> RFC patches sent for review only are obviously welcome at any time.
> 
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
> --
> pw-bot: defer

Thank you Simon for the information.

So http://vger.kernel.org/~davem/net-next.html
is no longer relevant?
(I was using that page to check, whether net-next was still open.)
