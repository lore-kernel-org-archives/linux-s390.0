Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012054.outbound.protection.outlook.com [52.101.66.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BA21FBEA6;
	Mon, 21 Sep 2026 00:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951248; cv=fail; b=T+QeVvOYAEYcz2DuAcRlED2ornYx7RywsG/8vy88tIFmn6eYE3vS6bIK8qq4NTysD2ZRjI9vFRbytHJxjCti3pCmw0kVtmrAhNBL7uK001ZNX+KeDiFV0Yny4Fnsw733LUaP85V826BLgmqf0+bq5mbbMWFYb+Gxvl87Mm/cz78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951248; c=relaxed/simple;
	bh=10YtoRfsZNae+Q4UEaD8+JhjvjPLiJvMKcmEEr6xKfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EDb3BqY/xMAfU6+MVp8QOsk2pEI+XKM+nxwPv/LvbxcvV3sWxfi/EvX9wEWNsfro27tJZKhloTbElmG87kYaRunPZpjARCZmOCdugaEU+Oc8RJMa4DQiA9tFLq0GmkZZwJa/MTFj2vt5slZdt1+QZaRoDkhn1gMeAn1BvRtgLLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=emS1YFOJ; arc=fail smtp.client-ip=52.101.66.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="emS1YFOJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQDbh2WfUaOwh1kpd/90+uhm2Po4CO+UnZCK/s7lFa1Tv398jvX8vxFCWEe+wxK8Ji8aG0Thx+6g5dARg1n2nGqhShN4ymzyAzkS7WMO/H0aIAZTaVo/gXKom6MFGn+pmGpv9lC+FbOzJPkwCP/DZL3iAWTiIuDXlNN74JgQKlg7aIWkt0K4JsgJPUMM0KrXmKlzTQqBHQ+v3tR5Iw3SxLGUafeHiNZrelrg7HemUEI3pYJoZihjxkDMMvokg449r/4lp5IFnPXk0V/X2ejE38+vGKburxstxrax+gZs3gXyAeqeF0PHq/1DPSp543dG+ZJjpi6Vk4+q3q2g0wST2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHR8zxk3b5Sv6o5/6gJEPz0abvSkXvr+aXa+BxYAaxY=;
 b=NVTXuIMKlzrbv1tVm1bTtTzAHkowN3EzrcMPfaA93pZDAX6GfbiebooUIn+ZksQvoCqGhVQ6jeHHWywarvp4aYYvbpGXkgcEQYRL98hoYrn1xeQKohZ4kTv339bMsxx2rbWflJIhguXvrwqwTxElwBH4c2prknmsI1TOuSjZz5vRLRBpMTvEiGXtQbiEbZKKNpQPvaOO5DaBs4sTAwcsbcJlZsY+yCa8DGm2KJoFrDhRNvv0tO6KGgl787cJw71z87S2eAcZ7kI4qFOPyipp5D050kBX5ZOECM99RAK0zo6L6zVFqFfqT/M3EVa5MKjfiKgXzQDNMUk00i2gFKVGxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHR8zxk3b5Sv6o5/6gJEPz0abvSkXvr+aXa+BxYAaxY=;
 b=emS1YFOJn3Qd8X8RAQgGR2W3RnMtHD9I8kz2Lusx3tSTCGxpQDyI/dAj93OgnuSVPswcQZX3DwB6VbRah7Hey2hppd7K2k1CD1AerRn+SoJQGv3EnCBr+mZa6crlZ6O190dTCuk7byrEU8RwqDo7+4wEz9hiJb22kQlQrKatd+21iTTmERUOF+4d3qd6qz3caTxRlrBdGmAXfB4S541fiJRB+MBYtCep6JLXhe91nZSveLH+1e/SuMU8IhlFfUSsrsL+hp9BG/LhSCUu+hPuLVEAagzxWohLxuitj5z62Scw8DuwyUUYWzDI2vczgyhWxy4tij/f/bu8X3kNNuS8JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS5PR04MB9770.eurprd04.prod.outlook.com (2603:10a6:20b:654::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 00:40:44 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 00:40:43 +0000
Date: Mon, 21 Sep 2026 08:45:04 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/time: use assign_bit() where applicable
Message-ID: <arB+EAGRKQ6OTakM@shlinux89>
References: <20260920022804.3145894-1-peng.fan@oss.nxp.com>
 <20260920162216.18515C2c-hca@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920162216.18515C2c-hca@linux.ibm.com>
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS5PR04MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: d88fe264-7f5c-435b-29d7-08df1778f80e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|19092799006|10067099003|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	XLInKcMk4hjeygD59aefCYBo1tMDF/wLXIS7FuZogNFiKGhbJQRM8kAwWDTvoDa82FsvTG6p5+XpJ7jYhYLga38nVn9IA2oWbitOTK0BvjE5cuEh6ZI9LWfKWFBdKvqCTE7v/kq54IcETNlwA/3qZjm0NOLisFSR1zWKlqsXlg2kdoxQODNCfNKQI4CurXo4M5OuZ37cCDdOJpMvmWDzKB37YfXJUtTNQ12ldj6DJKsNrWcV0Bg2sqUizmNSTSMWlZRg+Ft7nxGVpN5nTrV80uEiULNb2trJZj8jOwKtGcgjNPTFL1pK9ikpiXHsatMDNHRf8kj9seIYi8uj+0Hvd0nVmqw2fO+vag98zJy8H0fKABM8z5YtBWydz753LQn4KL4EtQqkawxYk9U+VgGc6zwcn+rkMhbSYLVC9QCoGD/rhS+Fw1DoA/d8mMhLGFf7T+Ev4F2z4XeTEBo+OvYLPwvyFLCkXg/ERrF4Ix1x+wgiLgfXPn5ex8b7maYX282p+BeMX605kHYE+TeQjRq3N7AuAJIC/EojErvHOcAtUz2g32bmRljmu4yG4DWY2Eugu5MjBjrOvyvgLXYZ9OLfnVrq63mzfMkliJJUzAoizvXHl6eQGLDohiI88Jwl/mPS5fc0N2Rutiu0VAB4M/nE4cdS9zzkZffJIRaE47m3mpc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(19092799006)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iu/2fNv1FwMbavvMioqn2GWZzmTcNloFFwbAhlOToZ7dywANCOmrhdWLM1xi?=
 =?us-ascii?Q?PgaKkSOGPslvejB31w8Gk49X1gyO0pQmbf8Hp8FlUm8r4aPMxlII4zfeTr6u?=
 =?us-ascii?Q?BMQKwGo+cj9O5U2ww1NvFXe6p7OZ+767Q64BZdFamQJtvKbd6U86ZjB8EVgz?=
 =?us-ascii?Q?UEBJPIrT1iR3cAsLuIZySL3NpTZDjT3Tjha+nPN+b8EyhqTY3HI5IvmJ5DdD?=
 =?us-ascii?Q?B0gJ5u4DYWwRX8yAOn1pAliweH5FZkvKluIspBtHoYVkt/MqvH22hWl+mjJl?=
 =?us-ascii?Q?VAgaWyCLmXw07Eyw66dkkID73TshIprEaY4TK4VMPWxoo1NhzuoNLxT+lk4x?=
 =?us-ascii?Q?jUY99LGsKA733aZq9QzhbWJZvbX4USnDTm69IEqMLq9Oe3xPRPMbmdgPSLjH?=
 =?us-ascii?Q?gx4fRh0FfaaQDupqy+7Wy/eXImOobnjuSHoHRKSFMsENGOdNtCKdI6RQLYP8?=
 =?us-ascii?Q?/31YS5JrEwqwgdcsX+qFKISVg7gyohroxlfP6/NGfVRg1YRzcppKz5supk1n?=
 =?us-ascii?Q?s+ep3mphHT2/LrSBTTVT/J3No2+rZlKr83aS69aIRUz8NhNMggAFWTJuc0SW?=
 =?us-ascii?Q?xC2R9iQVOpbCdIJKgm6HHOjVg/M0DcwldtSk2IqNGwxaWDLCG3pIbZ8njfOf?=
 =?us-ascii?Q?1iRG6zHRAo6y5Yfy/oXDoPn1BNoae+eDvgjpimbCSAtseatYDa0JITj5BUqz?=
 =?us-ascii?Q?d8SJ/XbH18lHPo3WHrhwevG7HI+dWJEec1aJZgnwhIoDdt/9zoMzY7VkfY9n?=
 =?us-ascii?Q?OeOVlKmRbnVBLdYfIwT9wIsju56gUYQ8awf4hKMHFtE2FdRbkmm3yxCrZrow?=
 =?us-ascii?Q?RC/bU5xfdh/GbQ2LAf2TNDU3u7dtywwlHvTUoXgX9LWVEztfbImUqa+xrKOp?=
 =?us-ascii?Q?tlMd/gwN7t8Ok5ZyREBFqjhnx9TUdy3qnUTsVf9zX9y+TX59Vi6u8/jhq3NV?=
 =?us-ascii?Q?GLaP/qJlxc1U/oAhDD3xXc6JMdH0PYKqUu4JQdgFXQoCFnXls7f+lPFUr+qF?=
 =?us-ascii?Q?3t+KwMavzYFOFORZ1l3Pa83yU3XoJvbZwBeRrBhuUqi/qEyraX13JfGrdxIZ?=
 =?us-ascii?Q?oAmu24zU1NLzsOzzqkPyZsfYzCeN3B1o60ak6caqIkgRAl7sqjgCVYEuX6VH?=
 =?us-ascii?Q?cebnxkgCnUeVJvhVElt6E++nsRarLpA+OWjHv4WuIlRPmufJ8K0yOun2194i?=
 =?us-ascii?Q?Xrx5joP795VDDbrgqaT1BKtjeHqW1le0uQHzx5cDBtsIrxTFMLkBKZaixSEz?=
 =?us-ascii?Q?rxciyH49/4LVrIjPAQ/DdIbsFWw3F1xozUZnkuqjerwc8+hDF9ehgl2wwyCe?=
 =?us-ascii?Q?sSWG0qBaUvIYf+cMVpechi7YGTwqRnOJKXN0ubw6NHZCt7+LFkhlUvbOUisM?=
 =?us-ascii?Q?q4zKwVDFN7GklM0mQgtUlyJvGMPHzTiqBUPK9cgVw6qbEeH6tUPQvMNkcnNO?=
 =?us-ascii?Q?ax3lnXp7cHX8PCMIaHyqsGTAEY0ci37PLs9tK6dHESA2wnubtY505NeaeNdh?=
 =?us-ascii?Q?tSfMW5FPz6C1aFruco+5fGML0B1hKV5ho5WGiEqReR0n2xVrwgllh6sipph5?=
 =?us-ascii?Q?9x29EQ+ebQkCaxzuC5ZJauTY+aIpPYvEPj3/73iKn/dLMXZ1ypMlzC2wL2xD?=
 =?us-ascii?Q?ijDTQKJPasf+rpRCb87t1IXhfc2wUm2bsfNMAljxTRLxEpt+/VrdkTYu2DnB?=
 =?us-ascii?Q?RuIqokkomc0J7Ps81A6sarhT+lr5ivzspelI3ROMJ5q0PXJCbds1+LcV/fhf?=
 =?us-ascii?Q?PaDSM7Vai7LqTqDywlr0Mg01w90vzv7G3CDO+P0xKGwETIYH8Nd8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88fe264-7f5c-435b-29d7-08df1778f80e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 00:40:43.7970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: or5Q+mP2Am2GGdlwHO4SmhM2gIIPBGVD60Jg4ywzDpmuEecD0lOzprs4TEvyRFsyB5ukg8NM01ED4RbH9ePNdhHLcGHEMD+HmU1WeLs2Fx03nZkiNbArKPIAhOwFOgOj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9770

On Sun, Sep 20, 2026 at 06:22:16PM +0200, Heiko Carstens wrote:
>On Sun, Sep 20, 2026 at 10:28:00AM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>> 
>> Convert open-coded if/else with set_bit/clear_bit to the assign_bit API.
>> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  arch/s390/kernel/time.c | 10 ++--------
>>  1 file changed, 2 insertions(+), 8 deletions(-)
>...
>> -	if (rc)
>> -		clear_bit(CLOCK_SYNC_STPINFO_VALID, &clock_sync_flags);
>> -	else
>> -		set_bit(CLOCK_SYNC_STPINFO_VALID, &clock_sync_flags);
>> +	assign_bit(CLOCK_SYNC_STPINFO_VALID, &clock_sync_flags, !rc);
>>  	return rc;
>...
>>  	mutex_lock(&stp_mutex);
>>  	stp_online = value;
>> -	if (stp_online)
>> -		set_bit(CLOCK_SYNC_STP, &clock_sync_flags);
>> -	else
>> -		clear_bit(CLOCK_SYNC_STP, &clock_sync_flags);
>> +	assign_bit(CLOCK_SYNC_STP, &clock_sync_flags, stp_online);
>
>I don't know why all those trivial helper functions which obfuscate
>the code are introduced. Before it was very obvious what the code did,
>now I have to look up assign_bit() just to figure out that it is a
>completely trivial helper function, with close to zero benefit.

This API was introduced by
9a8ac3ae682e ("dm mpath: cleanup QUEUE_IF_NO_PATH bit manipulation by introducing assign_bit()")

And moved to include/linux/bitops.h for broader usage.

I think it would be good for us to save lines.

Drop this patch since you disable it.

Thanks,
Peng
>
>
