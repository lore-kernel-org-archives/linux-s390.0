Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MQL7BxbA"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B7AED;
	Mon, 11 Dec 2023 00:29:43 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BB8Jhau008959;
	Mon, 11 Dec 2023 08:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fTPVzx3Xt7cgea3USz4oMf08V0jVZnDMR8c+j2HEy40=;
 b=MQL7BxbA4heCJ0e5/jrwxQSm1VIfowoVbFHq+lVUr2A34EWcRL5US7YCKTVB132hFhwv
 4p3YGz5gP0BwUFVKhDCSUuKtVnurMlNAxpRZxuQ81btHRVw2Wu7RzwroBFnqsqCKmdXX
 2tIbAGhzYzr5k1Qx1wW4okMpCxJgO+sy7SLbit3SEnGxP9+5dNnxa3O/qD1tag7dQvKI
 +EQU5mcDXCuEtLucfBe19J5urrv3WI+PN7mkiEBbnyFqa1i7Cce/xWC1FpdjP1AkUah+
 VF3X3WM1YKpQhyMbobV42Ybzs5gjTDsiUT6kuMmxjyFJrd7Wxelm0Yu0/gVTu88EJbJJ ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uwu4tx874-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 08:29:38 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BB8KQcO012570;
	Mon, 11 Dec 2023 08:29:38 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uwu4tx86q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 08:29:38 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BB62WIu005066;
	Mon, 11 Dec 2023 08:29:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw4sjyqd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 08:29:37 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BB8TYr543844250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Dec 2023 08:29:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FF842004B;
	Mon, 11 Dec 2023 08:29:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D72E20040;
	Mon, 11 Dec 2023 08:29:33 +0000 (GMT)
Received: from [9.171.1.164] (unknown [9.171.1.164])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Dec 2023 08:29:33 +0000 (GMT)
Message-ID: <1602d546-636a-4144-9e9f-bad4b5f2fd9f@linux.ibm.com>
Date: Mon, 11 Dec 2023 09:29:33 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 9/9] net/smc: manage system EID in SMC stack
 instead of ISM driver
Content-Language: en-US
To: Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, raspl@linux.ibm.com, schnelle@linux.ibm.com,
        guangguan.wang@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1702021259-41504-1-git-send-email-guwen@linux.alibaba.com>
 <1702021259-41504-10-git-send-email-guwen@linux.alibaba.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1702021259-41504-10-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bqbdL5zNIWrLfA0QxrleQYkPkdYvLS5c
X-Proofpoint-GUID: xgNRHnxNnaVoXruZgtJ9ZPfUo6fxlzYi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 mlxlogscore=599 lowpriorityscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312110070



On 08.12.23 08:40, Wen Gu wrote:
> The System EID (SEID) is an internal EID that is used by the SMCv2
> software stack that has a predefined and constant value representing
> the s390 physical machine that the OS is executing on. So it should
> be managed by SMC stack instead of ISM driver and be consistent for
> all ISMv2 device (including virtual ISM devices) on s390 architecture.
> 
> Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---

I've sent you a Reviewed-by for v3 of this patch. Did you lose it?
