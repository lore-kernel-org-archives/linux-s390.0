Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hM/SY68f"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6F710EB;
	Fri, 24 Nov 2023 04:55:31 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOAgIle000557;
	Fri, 24 Nov 2023 12:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rC6RkU15cboR+USOp/CKVp8YuHT+GrmeG1v80PFwaZo=;
 b=hM/SY68f4L4q4ppTo8gtfYUz2Uc8EldmZu+2pWxz73SHGDEtaLhxnmFk9LPTqO3AADU3
 L+3LbNDrmqSYlnPK4CBHpFylJlfBkKFGxW51DFFpNoiAsu1gsfEvgkCmvdT47jn62wJh
 AzgWAifXHGrmExq1mlMJzN3rUCEbdZsqFFZe/mAnTnkAKn4hlP6rgvpAE/elaaBuW/O2
 yW5XjRasxv7d7Aa/lpTYgUEbaYtjKEoIfytqe0Zsq2WEO3kxlXU2GT4WJsRATyvfn/Rv
 9/845kSeP6YPpotb2UTlEZ4PqGfptdjkdTUhNCbFcYfBcim70eRKdcetM1D8IxtiwIGz Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujtaek5tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 12:55:09 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AOCAvVG024735;
	Fri, 24 Nov 2023 12:55:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujtaek5th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 12:55:09 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOCIoMg019001;
	Fri, 24 Nov 2023 12:55:08 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf93mdfw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 12:55:08 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AOCt7Z210420830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Nov 2023 12:55:07 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FB5058052;
	Fri, 24 Nov 2023 12:55:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6173458045;
	Fri, 24 Nov 2023 12:55:06 +0000 (GMT)
Received: from [9.171.44.206] (unknown [9.171.44.206])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Nov 2023 12:55:06 +0000 (GMT)
Message-ID: <0c9fe1fd-affb-4f01-bad7-3d41b98280f5@linux.ibm.com>
Date: Fri, 24 Nov 2023 13:55:05 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net/smc: remove unneeded atomic operations in
 smc_tx_sndbuf_nonempty
To: Li RongQing <lirongqing@baidu.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, wintera@linux.ibm.com,
        dust.li@linux.alibaba.com
References: <20231123014537.9786-1-lirongqing@baidu.com>
Content-Language: en-GB
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20231123014537.9786-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ksx1VGtMpFwm5NjXN6K_Grplgwv-nnYX
X-Proofpoint-GUID: 3XOh5lgSG_XQ0EMChBzEW3LKOuGKU82q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=906 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311240100



On 23.11.23 02:45, Li RongQing wrote:
> The commit dcd2cf5f2fc0 ("net/smc: add autocorking support") adds an
> atomic variable tx_pushing in smc_connection to make sure only one can
> send to let it cork more and save CDC slot. since smc_tx_pending can be
> called in the soft IRQ without checking sock_owned_by_user() at that
> time, which would cause a race condition because bh_lock_sock() did
> not honor sock_lock()
> 
> After commit 6b88af839d20 ("net/smc: don't send in the BH context if
> sock_owned_by_user"), the transmission is deferred to when sock_lock()
> is held by the user. Therefore, we no longer need tx_pending to hold
> message.
> 
> So remove atomic variable tx_pushing and its operation, and
> smc_tx_sndbuf_nonempty becomes a wrapper of __smc_tx_sndbuf_nonempty,
> so rename __smc_tx_sndbuf_nonempty back to smc_tx_sndbuf_nonempty
> 
> Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
> Co-developed-by: Dust Li <dust.li@linux.alibaba.com>
> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---

To the patch, LGTM! Again, please copy the related subsystem maintainers 
explicitly!

Reviewed-and-tested-by: Wenjia Zhang <wenjia@linux.ibm.com>
