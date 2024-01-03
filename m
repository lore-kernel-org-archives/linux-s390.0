Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46EA1A27A;
	Wed,  3 Jan 2024 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PsCnd4aA"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403CiQQd031902;
	Wed, 3 Jan 2024 13:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hKmecFs/RRWrYz5D0rc4h+ZPupe+tSSdvSexvGo8rVQ=;
 b=PsCnd4aAWryjg/pd9M9E+qI8qrOywZjVtmRTXR2SP9sKBclhjfL4iW/INwpJ7aUYlIj5
 oI05OXgAZu0VJA2eoHlUONHqJy0PJuqSIC8O+Q+Hfw8dgPgtiw19xpxUwvN10R/nMIv8
 M25CXClc6sWXI5W1WB6/on75Ep85OAPrfNMbNHX3zgb7vIaUBbpXL74VY88SWjHT5H3g
 Ebh5S2oVucSKaWSiAoadaz5hLZ4z63hvraOchSnaj6Rrb8gP080UyWT39jKPsdFd8xh3
 LM25/u5IQksHqfJ9TWQZI1Ee0sGdEAfcAbRmDvPPM92LKCfEogsN9hZsfDJiZn/ZDsHM UA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vd5pqy9v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 13:44:55 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 403DgdMY024960;
	Wed, 3 Jan 2024 13:44:55 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vd5pqy9uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 13:44:54 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 403Bdvrn018008;
	Wed, 3 Jan 2024 13:44:53 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vayrkjvfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 13:44:53 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 403DiqmU48628006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jan 2024 13:44:52 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8367958054;
	Wed,  3 Jan 2024 13:44:52 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EFE35803F;
	Wed,  3 Jan 2024 13:44:50 +0000 (GMT)
Received: from [9.171.87.115] (unknown [9.171.87.115])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jan 2024 13:44:50 +0000 (GMT)
Message-ID: <41536899-3ca2-4413-b483-3d27ffe0d7f4@linux.ibm.com>
Date: Wed, 3 Jan 2024 14:44:49 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] net/smc: Adjustments for two function implementations
Content-Language: en-GB
To: Markus Elfring <Markus.Elfring@web.de>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "D. Wythe"
 <alibuda@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Jan Karcher <jaka@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>
References: <8ba404fd-7f41-44a9-9869-84f3af18fb46@web.de>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <8ba404fd-7f41-44a9-9869-84f3af18fb46@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UlqhGpdTe-RW-1HmA-S8Li9qtSf2T8ro
X-Proofpoint-GUID: Gs5N1HN_0NQFOW1laXhCwmV3ruGPYWlr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_06,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=769
 impostorscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401030113



On 31.12.23 15:55, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 31 Dec 2023 15:48:45 +0100
> 
> A few update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (2):
>    Return directly after a failed kzalloc() in smc_fill_gid_list()
>    Improve exception handling in smc_llc_cli_add_link_invite()
> 
>   net/smc/af_smc.c  |  2 +-
>   net/smc/smc_llc.c | 15 +++++++--------
>   2 files changed, 8 insertions(+), 9 deletions(-)
> 
> --
> 2.43.0
> 

Hi Markus,

Thank you for trying to improve our code!
However, I'm on the same page with Wen Gu. I could not see the necessity 
of the patches.
BTW, if you want to send fix patches, please provide the error messages 
you met, the procedure of reproducing the issue and the correspoinding 
commit messages. If you want to send feature patches, I'd like to see a 
well thought-out patch or patch series. E.g. In our component, the 
kfree(NULL) issue doesn't only occur in the positions where you 
mentioned in the patch series, also somewhere else. I would be grateful 
if all of them would be cleaned up, not just some pieces.

Thanks,
Wenjia
