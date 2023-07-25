Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65479C001DE
	for <linux-s390@archiver.kernel.org>; Tue, 25 Jul 2023 09:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjGYJMR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 Jul 2023 05:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjGYJMM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 25 Jul 2023 05:12:12 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A109D19AD;
        Tue, 25 Jul 2023 02:12:02 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P99GUt025005;
        Tue, 25 Jul 2023 09:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=FZ5tkW+LqRkrhJd76drqPREdcCnYZz91iXNJWsOvj1g=;
 b=qnjFf6yB7zQgirJynHIi6GtMJq+rA/24vfRw1gwH5LS9W8Ncvb5KC5knUKZoFRKBTjky
 /dlBkCw7CDkwaAXnoIhMiNQ9iZHS0pqOXD3cLhvMaeLaad78nqrWtCsDJVFdbZsQMh+d
 UWf8IC/Knf3Tp+Qvi1Y1p/Y4hMmpA1se1/ORncmQSAS++kWIOMssW1q6qygY3Nna7eqe
 AmYT6bnVEyYLnnLydZYtlrWWrQiThleMUyiGpPmaJJlEHrtdfR2AJNFUTewp1P4eZYui
 hd78w+G8M+b5P2orwxVfmCv166dyK7EbbNkmI6Se+smfkLcz2G2fb3kUXGWSEXHIOV6V PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s24q1rjhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 09:11:51 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36P99hdf028880;
        Tue, 25 Jul 2023 09:11:50 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s24q1rjh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 09:11:50 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36P78vs2001872;
        Tue, 25 Jul 2023 09:11:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0unjaa31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 09:11:48 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36P9BiGx21693180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 09:11:44 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C492B20049;
        Tue, 25 Jul 2023 09:11:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67A3B20040;
        Tue, 25 Jul 2023 09:11:44 +0000 (GMT)
Received: from [9.152.224.153] (unknown [9.152.224.153])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jul 2023 09:11:44 +0000 (GMT)
Message-ID: <3f12f422-bfed-ace9-7643-106ef29e4019@linux.ibm.com>
Date:   Tue, 25 Jul 2023 11:11:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net] s390/lcs: Remove FDDI option
Content-Language: en-US
To:     Simon Horman <simon.horman@corigine.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20230724131546.3597001-1-wintera@linux.ibm.com>
 <ZL96ut0OJdY8F3s+@corigine.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <ZL96ut0OJdY8F3s+@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2U_8DPVFTo1v2iHgldj7eXqyVOq0C6w4
X-Proofpoint-GUID: _ILwZbIy0v3UGP8Ptre9xfMYDFsWOIV_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_04,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=582 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250080
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 25.07.23 09:33, Simon Horman wrote:
> Probably this is for 'net-next' rather than 'net'.

Yes, this was meant for net-next. Sorry for the wrong prefix. 
