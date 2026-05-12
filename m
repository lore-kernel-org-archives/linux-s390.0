Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020135.outbound.protection.outlook.com [52.101.195.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA5239AD34;
	Tue, 12 May 2026 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595814; cv=fail; b=Tn4P37BiGYprnOyomQ74IfMkWMohYGv3UDVTCMLHm0u4EbqRkMd1x46khtg3wpMmF9Dgj9BFUCU1sfFXIFy6R3zuFxzjgioxNCawJv5Kuw/NFE/w8svQ13P6CBlEL1BzneCJpLzfT3gQrwsimZeTYlFCgvTiAhpfQMfoa+6mdtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595814; c=relaxed/simple;
	bh=Z9NKLmMolxyEzMq31RBpELOHousFao87FE5BQDaWuyU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=LipmTycaGzIsv6T3q4EucZNAuELzXezBMuQEI7H+UEgwToMTh0wgfe5+tE6Dfg2ry3Xs/+BnghS9fY/HQa7Db32i+Fm6o6Z8AsXoZu51emw31jyrMsHpaUnKZ7tS74YZLfIG4o5l1z+rsGDgXV0wYvTWOjLA9Q81vgQmVAvjizw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=cqo5KUsm; arc=fail smtp.client-ip=52.101.195.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="cqo5KUsm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBcBretHn4AvvZO8zSh7b1dQkV0U5ih5KNxs4U91st5pInA4rfV86de3r2wJOVS+uA5OQoODaB8HEZE1marAsHhGfdVbAi/uJMGl6YeA1lmiXSNaU4raBz4Ug1WIDPioS8yb5mCAeR+hlZUGAYse21NJe+bYMHPXDngT4B2DzOdaW3RXTIHJ9OHuQiTruc2Z+lJFKmQMIk/BKCmkikzXoVpmytqRC2YS3djnUWFW65xSfLHd4475ido/uOdqQh8UygA2hSHrmHwtun+q1Aqf1r3tcCHDJ8EMXjq+1SUuO2kIeuvRN0HL4BBKNDXLsCaOQJqEP96vK1G+eSDz/ImKLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nR0s47iaMnwr56nOrK5TtBpAboMNj76Id1N5Fi/z0sg=;
 b=QDvxldqsVBV4zuj80p5hT9FCx9YQAkmDRrJEGybrDj/3QREyFS8yE6DhXiLYBI1aQIHnYQhE6UshJfJh09b0udRRSbi5HUfpIScn1cwS4YFm9k2wmvkGnx39yPcRzYklptLVBPWvs8YEsa6oFg3Ao66Gg0sGHEWnVBepzzrK8lPuyQynDImRTtZkyOJhuscgwPxWVDjMPgE1pLRjaB4mY2oEVNIKC9PLElp/q9JM8ZadP+VPkT+CmBqiSQmNkMsgMpQqtRxhjJ2oCMbLGDRlrhd4MapunwaeLpwRj1yZtdc5GSsqsJUkx+AvB6M5LVvyN8q/DqZIsEStH/RQRGK+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nR0s47iaMnwr56nOrK5TtBpAboMNj76Id1N5Fi/z0sg=;
 b=cqo5KUsmXilzMd/9/54AId5Wzd0Y11m3ynKYqeYJR+F2LFWoEpUKShriVnwsqWYl1ifeHXS9ttv+daigKCGGvAgm/WLKrPzDGGCAZu5U5fRHs9+Q09L7BZt0oKVe8xCGOfOHkfPAKa0A0QLWLy3tU9n8Orp9BCD3Z6nhXDdxWws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB5407.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:245::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 14:23:30 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 14:23:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 May 2026 15:23:29 +0100
Message-Id: <DIGRLF10SIAG.RD82P0JVLZOV@garyguo.net>
Cc: <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <rostedt@goodmis.org>, <ardb@kernel.org>, <linux-s390@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] rust/bindgen_parameters: Mark s390 types as opaque
 to prevent repr conflicts
From: "Gary Guo" <gary@garyguo.net>
To: "Jan Polensky" <japo@linux.ibm.com>, <hca@linux.ibm.com>,
 <gor@linux.ibm.com>, <agordeev@linux.ibm.com>, <ojeda@kernel.org>,
 <peterz@infradead.org>, <jpoimboe@kernel.org>, <jbaron@akamai.com>,
 <aliceryhl@google.com>
X-Mailer: aerc 0.21.0
References: <20260512105920.2426293-1-japo@linux.ibm.com>
 <20260512105920.2426293-4-japo@linux.ibm.com>
In-Reply-To: <20260512105920.2426293-4-japo@linux.ibm.com>
X-ClientProxiedBy: LO4P265CA0055.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB5407:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d226022-d770-4dc9-96b4-08deb0320a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|56012099003|22082099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	rJj7XKVGgvsxiyK/Nn+/KE3f6u3tXzeFIFd3h0tiJLdYnt1+k+aci0mK7j8wybKv7mkgUByE3A+Q8JC3Yiwo/8JaXcmW9HtU0uP4pvwpdzPQtjSWEBnE55UR4yHXcO9C9uPTPLxgRGqPOPAGJqWoYzj69wgTETTUG1CjFeuB0io+UkynqofXwyeldfDCiKlq49iZiQ+TqwKgcc8Kn6sZ9LN2mt4jdDnd3Csg7s+k3xQgRGVgCN9IOCGeVtHqirEqDvhAk4P+pjWw/U/xWWIJG8NtKeuIG4db0altt1Yx0yrprEG3VMGBGAkUrjQHxYsKXBei+41CWNuyRU+bjzdSU+XvS1mHIGKJlZ6haZEBj4KrNDZww3wnOWif0OouS69PYdlvFNCU8mCG/vDJvdEIiSy132Bj4OLYEKsI4yo4lZBFAxdGBWfM2tOOjKBNF0zzZFn8N4Zj5FTsGZqlSQtnnVHB+/jt1FXeFhP5b0kxz9ODEBP6yiLrQR10yWbgS9LyiQNqKCKBv6vyhSqwArlEQKZhQgHC7kw4aT3Dm7dN9VH196s/lj4Slj2mRScFg/0JYSuLOTWCd5M16hQZVbpmCw2uaLbJA7omu55R6Y9zfLJpLwsPbCCSuNucMrnzt82eYxTmtQR1vI7gr4qF7NGz8w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(3023799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3JZMzRuVXV6dlA1Yno5Nmd2aHBRNk5DOGpZM24yMTBhYzJ3VnFSaUtJNHFp?=
 =?utf-8?B?bEdhYmJJRExnaFlTaXIrbVF3YW9iQTlpQlNxTGEzWmR1SXZqTDZYSlBETlln?=
 =?utf-8?B?K3liWklGam03ZXg4SUgxUi9IdnIySEg0aGhkeUVvbG1qaldUWXhhWUtGdmlX?=
 =?utf-8?B?cGFyUCtTS0lWcHNTZ2NGUlRQZUx5b1RmbDd3bGtGZ2pOMk5TcVB5NTJYeUFa?=
 =?utf-8?B?STVoRjdSMGVwTDZIZ3MrbUJTVVo5R3JLcUNvanhxWElTcVhQUERtN0JuNGZU?=
 =?utf-8?B?TkFhNU5DRTdBRTI2T3NrL1ppZ3IrUncwcTlaTVo5b25McGdlZXhtMjhRK0d0?=
 =?utf-8?B?Nms3RGZZS2VkREphTEh6ZEVWcDVVcDlaNGt3OXluOW1kYzlWeWlpM21aSDRh?=
 =?utf-8?B?Wmsyb292L0lPZE14c0NOZDhzK2IyZ1FZL003N3FWajRIRWxJVGlDZVdEd0Zr?=
 =?utf-8?B?VlYzR2pOMUVQdkJpcGZUOVZCZlJhQUtGK3FsQ1IyMThSRlV5ai95NXpwclAr?=
 =?utf-8?B?MEovcUd2ZWlHTUFjQ2RieXp1T3FOSGpiQ3dZMjVtRHZBcjBPWVVlT2NmTnFa?=
 =?utf-8?B?OU9HTjQ3OHExVHhCUHlEMWoxL2xzam9HYzUrdGlXUksrSU9USmhhRXFROGtl?=
 =?utf-8?B?U2pIeVhmNXhBcDczN0ZPQi9sVGQ4bE9GZ0lzRmd6blRkTmVydi9CTDJaUVJs?=
 =?utf-8?B?bkZRK1NlQ3pxd0ZyNWMxN3k5cTJKVWlycUJYSTJUZ2lKZWFIeDFnT2ZZdWtV?=
 =?utf-8?B?R08ycXJVblAraXFnczBjRkRxRHFXS3d3Z3NobExnWW1TUGcrdUdSckMwS0hN?=
 =?utf-8?B?a0tadk5VQU5TUU03RDFCTDNvTG9KZEFVTlpGL3EyOTVSRlI0UWxlbDVCWGw2?=
 =?utf-8?B?OTZYbWFMT0NjNDBpZVl3ekI3NVNxei9adDZXMU1KdllJbEcxa3VadU1xWSs0?=
 =?utf-8?B?MXltM20yL0J3YzJCQUZqT2V2ZS9MZ1Q5RjRaNWQ4ZWVLNy9UR0lpblpxL1JV?=
 =?utf-8?B?Ynp3ekJiNkpmSzN5dEt3ZktHNDN1YUpINjROSmpGb2ZScnFTTW94dndJc2Fl?=
 =?utf-8?B?NTJYNVRjbEZRT1oxdmYvS25BdGRuTkhWcTZXSUErWXJKODRXSjJTd2IzaEdY?=
 =?utf-8?B?REFkdjZsVStObVJWQ2l5WGlQZkg2TVBYdncxK3NzTmY4U2R4SjNTbkY2M1BS?=
 =?utf-8?B?U2lSTVp0czA2Q2VESHc4L2Faay9CeEZDUDg3RGhBMlRrb3Ntdk0xeW96TC96?=
 =?utf-8?B?UUdzRUZGbDRJdjJabm5pT1BwME1Yd1VDOU9mZGZSZXhDbVhuYVdCZXQwVU4v?=
 =?utf-8?B?RG5mb1pxdVNWYVIwVmVhTXhhall2L1pMTldSWTdKUlNDY3AwYytRR2MzN2dj?=
 =?utf-8?B?NU5JUjhCQ3N6ZVkwemRoZnY0WnZEOExwelFjRldUQkIxN0Q3ejN6OFUydS9T?=
 =?utf-8?B?Rys1OVMzRmlhQmhoVHg0U2ZHRkhicXVlOHhpeUlmNEhaaWQ0aFh5anU5WkVY?=
 =?utf-8?B?ZjJMNXdsSjUwa2RaVlArM1Z0Qm5PUUJFMEQxTS9BUmdOSGFXQ0ZmWG9NcWRQ?=
 =?utf-8?B?dWxQTGt6c0FDaldQM2V3VHMya0dXWmd4cS9EN2pQbjdTbG9zTFNDcUM5MzJ6?=
 =?utf-8?B?Z2dUQi92U2FEenNrWFpjK040dkRZMmdYWlNPRzFUaXVTZW5KR3FOdkN6T05Z?=
 =?utf-8?B?TU82UXZlQ0RpeGJ3aDI5b3dYZm1aTXNxM0xhWG1ZdDJ5aldnQXNtaGF0bjRT?=
 =?utf-8?B?NzFQa3ZQdU1qVXA1UkFtUDFFclRsb1o0ZW9yNzVYWjFuR2RSUXVGZVNkYlhs?=
 =?utf-8?B?bTBXdUpVeHBRb3pyT0UzWE5EdXNuT2wwM3NIM0pPd2RDWVR2UnJXNm9RNnhG?=
 =?utf-8?B?VXJnV2pvdXk2SkFBRUJuTjlubStkK3BLK2RGVjhJOUxnamVaVndyMUVzbEFU?=
 =?utf-8?B?UUZKQlBzZTJQaWJOcDZiUURrS0JPUXRpWWI5TTBKYUo1VHRDcndtOVdFUjRq?=
 =?utf-8?B?YVlGWllaWkN5K3NBRGhUVlVaN0Y3eEN6L3ozVHpiTmM0WUVrdzAra0ptdUxB?=
 =?utf-8?B?a3B1bDMzU0dkKzdaT3VYZUtJZFNqUHZlb0ZPZHJ3bHk2QUg3MGlpWWpTc09N?=
 =?utf-8?B?RGpUU0s0VSt0ZlhlOTdYK09GV2FFdFc1VE13cHF4M3orUjVsQTdNQ1d6TDZB?=
 =?utf-8?B?VzdmdFdjdXZaSVEvbUM1TWtzek1ZTlpRaTdDSkdiSXpWN3NhMjYvSXFRaUhq?=
 =?utf-8?B?b285OC9lSGkvcHV4dE8zWlo0akFXTVNZbUpzbG9zQlpWWE40UC9xeVUra1Vv?=
 =?utf-8?B?MitHSGpHU2VHbXYrbTlRS0o5Um1idXJmaXlBQksyZkR2RzYzVHREdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d226022-d770-4dc9-96b4-08deb0320a39
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 14:23:30.0254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4444/HY9HLHowm78W59xewvJtxyBAE09NDFD5h83ZbziFx5wM3KRK91Jaaimje4fw5lFQnAi/CbXUHJJhjcSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5407

On Tue May 12, 2026 at 11:59 AM BST, Jan Polensky wrote:
> Bindgen attempts to generate Rust layouts for a number of s390 structs
> that are packed but contain, or transitively contain, aligned fields.
> Rust rejects such layouts with E0588 ("packed type cannot transitively
> contain a #[repr(align)] type").
>=20
> Add the affected s390 types to the opaque type list so bindgen emits
> opaque blob types instead of full representations. This matches existing
> workarounds for x86 types such as alt_instr and x86_msi_data.
>=20
> References: https://lore.kernel.org/all/e5c7aa10-590d-0d20-dd3b-385bee237=
7e7@intel.com/
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/bindgen_parameters | 7 +++++++
>  1 file changed, 7 insertions(+)

