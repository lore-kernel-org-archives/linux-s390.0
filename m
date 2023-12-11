Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U284KQe8"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8041B6;
	Mon, 11 Dec 2023 03:37:20 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BB9qqjl019534;
	Mon, 11 Dec 2023 11:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sGwW86/Z0Trc+yHiYF3uNzOJmXmzBEn/37dRO0PcYgg=;
 b=U284KQe8vLFE8g1g0tzsggf3uc2sW6EOO+rRFnn5MoiZWuvfCrzIkZnzAkTOtvo0S6fd
 4waVClC5ImQuOknHYRf79eYJb6keQFhN4JDUM295fBA2xEm9rvp/45ZFkx+2v26pWr5s
 2E0sR4lozMT13axoXlWFXi7mVPPFIjrGx8I7MC6P+T6Kvin9Wgr9MeVEBNgNGyoy7Pl2
 +lBYMZWmgRgQtjC//w7jijSCc5WgXyqLF699mEtOEnEXpO/cX3f6k0H7DQXAxnSLI21a
 GgnWihzhSTTtsJfn2reIM8oVg2mc/w9s4iy5yqbMrCs2GSTaICTiIiwJyRfWRdLtNKqc bg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uwwj9q60q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 11:37:17 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BB9tEmS025166;
	Mon, 11 Dec 2023 11:37:16 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uwwj9q604-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 11:37:16 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BB9E18L004101;
	Mon, 11 Dec 2023 11:37:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw4sk0nkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 11:37:15 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BBBbCE544827054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Dec 2023 11:37:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B7B920043;
	Mon, 11 Dec 2023 11:37:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 010B920040;
	Mon, 11 Dec 2023 11:37:11 +0000 (GMT)
Received: from [9.171.1.164] (unknown [9.171.1.164])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Dec 2023 11:37:10 +0000 (GMT)
Message-ID: <021fe50f-a70b-4d2d-b16f-25954be4e31f@linux.ibm.com>
Date: Mon, 11 Dec 2023 12:37:10 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 6/9] net/smc: compatible with 128-bits
 extended GID of virtual ISM device
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
 <1702021259-41504-7-git-send-email-guwen@linux.alibaba.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1702021259-41504-7-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GF6X_gFLrDcAbTt6A9cnT5hygbTNdeBS
X-Proofpoint-ORIG-GUID: DZ81H8hgjrB2_emnFSsBbm218YoM7fuH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_04,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=845
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312110093



On 08.12.23 08:40, Wen Gu wrote:
> According to virtual ISM support feature defined by SMCv2.1, GIDs of
> virtual ISM device are UUIDs defined by RFC4122, which are 128-bits
> long. So some adaptation work is required. And note that the GIDs of
> existing platform firmware ISM devices still remain 64-bits long.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---

Thank you Wen Gu.
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
