Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021108.outbound.protection.outlook.com [52.101.95.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD63F23A2;
	Wed, 27 May 2026 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779879260; cv=fail; b=eOUf5ZK7/vl3ekrUl21P7foQWvwYtyrkp1pp4HkYUSO3/Y/87w9zkSBXnMpdZ9OcPS7ZJvSe/HrTQk0Ex6dCGxxXopBSsKvrT512XWfKT1MUqC+SGoQLvtchFcRqFJgrHeZ2YBlhW5lptcfVukg5iaGbXG16gKgzl0DcWQd1p5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779879260; c=relaxed/simple;
	bh=6ifvgBqpPLNnQYMRW9eMwC6ovlrZ8O0d601r+Ck41mY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=YiAvG5iPGNDgE+WDL49NWk37LNn9dgqAk+x0JzSOdWCILVoxpHmFnoNLgvpaHQjq7AxeAtynILaIvwonx74fVtexHLc9tDMMgS6TzApD8XI4TcMpOALpUhxByu5Qa0enhZL2XPzMh8Ai9ofjpvDIVlwYtJ/kFuf+TldabOVhPDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=XmPLJvuu; arc=fail smtp.client-ip=52.101.95.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="XmPLJvuu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6lz9d5ZAledLN7pGBWQoy1GV7oApl3tBtJba4Jgp0ga9kmn26rMrHqG4hIBoB8PIywQAPJD43ikBO3oHCELlCRkoxcqXtRlQiZuM/mFOmlSsIGttErmjSU+aarvuxwQIKCw1WQyJF5jAMYtBCLzphCK+kATPJ+SHI+YrSVaXGdmumbZYcpWiDPjU59DDH93NjjZPn9DYoUyHbGiMchRsiG2xYGiB4/bPz6LpZ5TJ19V2Y0+Ukg/pPI4OjbOp5eO5mOBNQpP6f/W+EFxlus+1lBWFfafQ2yRtHplDBbsmKgSR5/Oly063A2XjP9vRpMi2nE9lFdBpFCHBkiONSoEDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBp1TvreGdG82yE1BOkYvIJIPSrg2/Evjxqn7VcARb8=;
 b=cX4ttyuT6jcm6H0RnefdYusPe1Xym8gYs0aJLwbKGHqAkWPIwK1i8e/RfXOfuAiM7uiDlGwVA3WGxJeXLXkdNIxC42mQJUUkBIhWPn2dh7UxMtNz0iR48bKBlbhI47zLaJHq8l+jPoH+nZdxXxZMa1FY5M2CKunI/NwKIrfgvruKKpFf7CLHH/tPYV+y/MgpNEMOItlboW7Z74It8mYAXo6VF7voNhANDYAPYfj43oPYgBrBPhPCWsHbzPjlgRMzgj1yVuUYne8gIgc+OP7JtQ19fEmtuJ0F6GEY0by2OCjzk+m29AF2obZJyuDCBf6fWKxWSgPufqvGIeMtbwLbww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBp1TvreGdG82yE1BOkYvIJIPSrg2/Evjxqn7VcARb8=;
 b=XmPLJvuuh300E3kjkzY4wTxIzUFkgr+quV7T+OlW8Gf8PoxQnpCz8Sb05QFlRlBNDRSinasmex/TtcumMMZM3gEfSzXfW4RRh9Np20569F9ZQNgCxwRGQM3g+2Yc2zYjPVndU5ag3FPXCiUIsAMAiTO9SgtAsCGOzBselBgVIx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB2819.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 10:54:15 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 10:54:15 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 11:54:14 +0100
Message-Id: <DITEJDD9AQS6.2ZCK05WMGFMDI@garyguo.net>
Cc: <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <rostedt@goodmis.org>, <ardb@kernel.org>, <linux-s390@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] s390/bug: Provide ARCH_WARN_ASM for Rust
 WARN/BUG support
From: "Gary Guo" <gary@garyguo.net>
To: "Jan Polensky" <japo@linux.ibm.com>, <hca@linux.ibm.com>,
 <gor@linux.ibm.com>, <agordeev@linux.ibm.com>, <ojeda@kernel.org>,
 <peterz@infradead.org>, <jpoimboe@kernel.org>, <jbaron@akamai.com>,
 <aliceryhl@google.com>
X-Mailer: aerc 0.21.0
References: <20260521165622.279953-1-japo@linux.ibm.com>
 <20260521165622.279953-2-japo@linux.ibm.com>
In-Reply-To: <20260521165622.279953-2-japo@linux.ibm.com>
X-ClientProxiedBy: PA7P264CA0286.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:370::13) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB2819:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6ab8cb-c71b-4442-a4a0-08debbde4b2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|22082099003|18002099003|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	a3VH+ez/yzrQVqPEoSQQdgDzMmv+QAiD/AXE3YQiAtuSFtnodQLIdVMe/03BdYDm67FEQfKbvVzFdyDtt5Sf7YoOowyJIRBtGDm32Ie0eY1/Yg04PXvlbK2eKGdrX5HWlXsF9pKZ/iA5cz0OmAmQStioKtk0W7n7i7biAx1D5qyHKxrWsBY3XOeHUKpZOOMGd1mWgXkFZoDbagg9DFJokj8reRnvUo3RYNm5IftybQCdkYQSVOuuiglySyLDxsYJoAO0ef95XMj9HM4gKOLKKDFxUDXQJfNN7YMEdXbLSVhtVJ4POjdXL18rLtR9+w1TEoJUQQZNJN4bh2hV7pHDDIbjmkVHZCxLrxAJ4FaBLTP0+XasxhzEVDm1uJP6RFpRCC/Yxuy7b4O4bzgiS+c3sXBwEaXbedeIq80xWOfKTGTjy5LsPnboMzKRLsymYtFIxhTutVGE4hMXmKIIAOZQZKuTPm81H0coxPvhN8oK2haSWE6E0XHisEQahTyp7IxB5NVU0K0lWhodTBMWZ0MOoO98de+rmDzF9CpeTA3/4AMQO8kml2MHTYaWX48TSIdxQB51cmsnkdS0T1P1lUftqWq+Zyd4OgPbenPwwkm0u6K8DS1cObnCBhKKAETiEdh0xBzHS5zqazcYyMsZv05BBREDAAuLxU7olsGtmfAhcth3QNxxe8Wc1j1m4YIHufQE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(22082099003)(18002099003)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnhMNk1GUHFxbkNEN0ZGai9hcXZwc0ZzSm5DOG5lU1FzOGw2TE8wT3czejdv?=
 =?utf-8?B?R3JGWStpWjdWZEUyUC84VXNMU3pZSUpXR0JNZGZuRzNaYUFBdlljSjZpYWZC?=
 =?utf-8?B?RC8rZ3MwVnVKNFBuRm40ekxRQ3RSMUEzc1RFNkZ1cTRWVVcrT3RyUk80Q3Iw?=
 =?utf-8?B?ZjYrWk9zRkU2K3JpRThXVUV4TGVZdWFOWmtycE0rZ3FnMDEzejNNb2x2SHpF?=
 =?utf-8?B?bEw0VHJkTXVnTVM4bkxaTmkvV05DWTBiQmpKNXE5cUFGUXZmbWR5Z3dRalJ4?=
 =?utf-8?B?NTZqbXFJd1Z3R2M2NG9HZDJ0cGlVdkhHVC9QM0Q5VmxxR29Ba1drREc3UzZ6?=
 =?utf-8?B?TkVIeFZCejJabXlHWjlWWjZYazJoWktKeDBtVTczSWl6ODBDWmY1OUdxNURa?=
 =?utf-8?B?NlRvMGRPNndEUkIwRERxeFpTc2dNU3EvRTBYNEZFUUgzMEpiQm5lUjhMRDBE?=
 =?utf-8?B?VnVtZlpET0tLRE9IV25RYTBHeHYzeHZkdkcyV040L01Qc1RJazRYRlA4b3Ex?=
 =?utf-8?B?bW42V2NKd2JuTk1BTVozRGRXVTN6WVIveTNKanRhd3RxVGFUNzZlTlRIWXRR?=
 =?utf-8?B?ZklzS1BWN3hmbHJ0WmUzMlk5WitpeEVrcmlqbzZmNU5qSU5rS0M3STYrSlFP?=
 =?utf-8?B?Ynh2LzJ5d0orTWVIMGNld2JtZ3hnb1FId0JhbXl4Z0J1Qy9IN0h1RW80b3h4?=
 =?utf-8?B?b2M4YXl4dnpkZGxVWXFXU0lFTEtoL0V2Y2lOd0o3citVNStYdEk4WlV6Smxy?=
 =?utf-8?B?UnFrNlh2cmJseDN3eTZoN0JnWG0yZDRJK0dzWkkrNHVhdXFwM2l1UzFvbDFr?=
 =?utf-8?B?aEF1QWttOUhybzNWd3RYUDJUS0NnNDlmbEhUZXlja29XcXRNZCtpbGllczQy?=
 =?utf-8?B?R2NkVEVLZGhSMnRlaEZScUtDV3BTc3RPTDdKT3czWVdhQ2N3TU9iK3d3NVRx?=
 =?utf-8?B?UFJZN0JUTUY4SlZ6eXZtTlNrbFBJSUJ6aElLYUNkZlo2dWZYWWJmOEovQnl4?=
 =?utf-8?B?SFQ4M3dCWDFsejRlNklHUDRvYXJSaGs5US94YmM2MnpTdml5Y29mV1hLME1u?=
 =?utf-8?B?enptOTc4V2ZMeHpYdUI0enFPVmllL0tjOTROZHBXVGN1RGVCWUpIaU1oZGhL?=
 =?utf-8?B?ZTZWOVNYNE1LYlppdnNadHZOSXF5MHpEL2wzWmx6UkFnZ2NIRGJab0p4WEp3?=
 =?utf-8?B?Z01VaUI1N2VzUEVjVEZhcDZKcEZlaE94QVVzNGp2eTVFWnROSXp2bTNQR21Y?=
 =?utf-8?B?SFYvdGQ1YThneG0rcWxhdEdRdUdidVhwb0k4YTUxVmI2enhXeEpKVWZrY0U2?=
 =?utf-8?B?TlZQT055Q3gyK3Fvb2lhV1NBeG1ocTlweHJSRVg0UXk2cGJVeVgyY09JTmkv?=
 =?utf-8?B?SEkyV1krRzhLWWhNUytRUmh5Sm9EK2oyVnJlQ1I2RUVFWVcrUEdlRUFNZGFJ?=
 =?utf-8?B?dzI3Z0g2SDVmQVN1WU53WHhHbjl4Z0J1eEZKQUhObm5xdlY5aE9Kcy9NNDE1?=
 =?utf-8?B?aXNoVVppLzVqemIxVkRzWXE0czlMaVBSN21xK1pLNHBWUENmM0VNZjJxSzF0?=
 =?utf-8?B?SU1MNUJ1dllaMVM0bkVyU2JTYXdVbGYxRktPNGd3MnVWMnVuUUhDR1V3QzBL?=
 =?utf-8?B?dWhxU3ZLaE56eUdva1djK3UvQjgvR3JyNDhxaHIwREdOZUN4a3BmQ09IY1Rm?=
 =?utf-8?B?Y3N5Z3Z3amIzRDYxOHVDVnN2NUhGc2doelozUGMvaVpMMURYeVpLdktBekZq?=
 =?utf-8?B?NzlvMTlxOGJMb1A5QmZKcUhiTEI3ZEV0SVNadjVkVU1Dbm5waWdkWm9qVU9S?=
 =?utf-8?B?M0hqekdRaUFEZnRXbUpkd3pEdmRUZ2d5L1JlUUhXNGUyTVBRQ2RjbnFtRms1?=
 =?utf-8?B?VXArdDVuNnRBUWN4cjA2KzYybjY3dkpBZTRRTWx3MDN1MzI3Ry8vTnlNZWJY?=
 =?utf-8?B?V2krU0ZqMnI5eDJTTVdWMGNlWFJlN082K1czRURGZ3YrdVlYdExva1BxUGhz?=
 =?utf-8?B?NmxzdG1qaXJYNE5ZU056dUJYZlk1UUM4Mm1Jb3JQR291MjN5aVV4Wk1vSlB2?=
 =?utf-8?B?MmVzZHlDU0RvZmV5MG52TGNBMkh6R1gvTjU0SzdTVGthTjFkdE9EUzY3LzQr?=
 =?utf-8?B?UmJqdTc0aUNOWHVhOFA5R1F2QzNodzF5R2VXRVlnUXRwY3hER1lwU1dxYlFB?=
 =?utf-8?B?UGVER2c0dVlRdjliYmdVM1cvMWJWbkx4ZEV6QUcyMGdzMFRiM2lZUklnZGs0?=
 =?utf-8?B?SldCbHRlWWpXZ2YrS05yMmMwTVMxa2RON3pxM0NaSmtaZnN4YkhyY1BYNy9H?=
 =?utf-8?B?Wk9kRlIwK1o4L1d0dHVrQm5uRm5HVXQ3THpMWEtoT0xVbGd5WEhCZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6ab8cb-c71b-4442-a4a0-08debbde4b2a
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 10:54:15.2472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enZRyRiRk8G3pYLZBHv0KR1pb6+WdeVbPQS0GyioyoUtWjajJ5yvxSTZ/Zt4Oc0intBsHuoSff/B6PNUuS3Phg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2819

On Thu May 21, 2026 at 5:56 PM BST, Jan Polensky wrote:
> Rust WARN and BUG support relies on ARCH_WARN_ASM to emit __bug_table
> entries. On s390 the macro is missing, so Rust code cannot generate
> proper WARN/BUG metadata for the kernel's bug reporting infrastructure.
>=20
> Define ARCH_WARN_ASM to produce the same assembly sequence and
> __bug_table entry format as the existing s390 BUG handling, including
> the monitor call. Define ARCH_WARN_REACHABLE as empty since s390 does
> not provide reachability analysis for warning paths.
>=20
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>

Acked-by: Gary Guo <gary@garyguo.net>

> ---
>  arch/s390/include/asm/bug.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

