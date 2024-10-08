Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB428F6C
	for <linux-s390@vger.kernel.org>; Tue,  8 Oct 2024 00:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728347348; cv=fail; b=Vsoc3kCZ/UxcfUEEERW4+YNOzz9q6aI0rJYiMaODoDRzf+WbiDtkx2X1GF9woL9J+C7hE3p9X82fQd+65vM0YUkznISvnDryY6+5j33Is+x8iSLycJ+uqMc+KvjtP3s4tW1XJQb9fdS8CuXSLmuYue9kxxECKE2UlG9b+Yv9pYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728347348; c=relaxed/simple;
	bh=tmnuRvBdfMEz04X9PkZzhhyYOKbTy57nboqV7L8z8hU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fl18c8TamDfEy4DCIx06FABqNUz+uoaOJpyXjuRx9Aifjw06nIRWRBjhFVZ/swqwt7occYN22Qxjc53YqRfZ145M9Kr7u2Cj55imKNJGMwFcy0yodXmJBdZp6KlQu0Q04yNGpJy6Tpt8jmgE9B3aw60gS2OT/xga+6Tzo3+W6Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LrMvBxm4; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LrMvBxm4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728347346; x=1759883346;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tmnuRvBdfMEz04X9PkZzhhyYOKbTy57nboqV7L8z8hU=;
  b=LrMvBxm4OgRjRaVfTWxhrx9EIO5s9kZgzigZoY9h4N8AKzmZogQL+OVb
   sx17hqJlmuS8xCiljnZ1kvPLt5C5575qlz90/6HDUhRssPmsltbLf8mDc
   3AtHTRTo1cxTeRhlz2/BPa//q291PccO60azu4xcWoCIY6rqsZa8g2bMF
   AI83N8GgaVah1bMYZj0FENWBBD+GM2wh336n1lDsl+uMQtLHloLB1tgYO
   T5R7z3zmU1GG5YXePnQCYEOvI2gkS3NkgYJwJeyj2LsyW0xilW54fjzOE
   N1C3EyyYWySiyNfruIDbpvkCE4RqpzvaahEd2cAMkrxTwhFh/sWSw5/Wi
   A==;
X-CSE-ConnectionGUID: h6f0UlUUTWOP5jBDs+N8gA==
X-CSE-MsgGUID: jQBg4B8vSDCgWi7HdO5NYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27651705"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27651705"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 17:29:06 -0700
X-CSE-ConnectionGUID: BfAr7Oa5TE2OGUHaF7DCOw==
X-CSE-MsgGUID: mwJjT2+vTtSx2cTFF1o/Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="106401690"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 17:29:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 17:29:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 17:29:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 17:29:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 17:29:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFe7kCWHBS+r1CESHqNdfINfUuKh8c1pTrXs2q83Ftgk23GXpYJFFBuJewEtgY7JS1XROuDhQaSyrlypA/019Xa3imYGU8OiOmo0iSf0/rei3lSAXyjfQrY9ISuHS+SXIIKZii8ldaBMyXRcFHPnSC+lqndZ0DKBOw382RYylI5jLzJ/JjSUB9MXv0u+URRZVVD+/a59uFADOMfLTboP5zgtFQ5yu71D4x+cDxD98flscM7qZosk4zVB7oGxO9HUWXbbVtcT1zmB24/73Fk6djkaeBEWGxlWYJQ2bqMUKk4Rf1YTCyrvQeK7zVwkx++zD2I+0UZQFZtRZJ/GJ5i4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmnuRvBdfMEz04X9PkZzhhyYOKbTy57nboqV7L8z8hU=;
 b=pht77CE/hqwPfGjoxLwcD2Tsj9LMdjpTQ9iDVAjSc7zRdgR7vdnjtELxNJwkiC9kzVC6GjjJDcWIGL45IQeuVsFMI1vK5fIfKFEEUqWqEUzvRYOvfQOn5UYLWjTC+sfjD/1TASZ68qPGE8H04lFRXQGJWS6jvD/F6zUyfcLPnD1W+T9X5++r0W6uLVqCdNMmxtg8JeKqh0CKHMTEqIm0Wu+98TWDwXshxmevGxKritPsd8uSabkcw/SrUrjJndMjMdURtd50JoTvbUXdnqRvXyQh1gb/4ZDjGibxi7h6lvTxvGeBWmPCdrbarGFEa9W92EwyaUdbTNQNjpuVeN+WvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7641.namprd11.prod.outlook.com (2603:10b6:510:27b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 00:29:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 00:29:01 +0000
Date: Mon, 7 Oct 2024 17:28:58 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, Jan Kara <jack@suse.cz>, Matthew Wilcox
	<willy@infradead.org>, Christoph Hellwig <hch@lst.de>, Alistair Popple
	<apopple@nvidia.com>, <linux-s390@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] dcssblk: Mark DAX broken
Message-ID: <67047cca7981b_964fe29451@dwillia2-xfh.jf.intel.com.notmuch>
References: <172721874675.497781.3277495908107141898.stgit@dwillia2-xfh.jf.intel.com>
 <20241001122925.52558c08@thinkpad-T15>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241001122925.52558c08@thinkpad-T15>
X-ClientProxiedBy: MW4PR04CA0331.namprd04.prod.outlook.com
 (2603:10b6:303:8a::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ac1493-583f-43d7-aa7a-08dce7303519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FFFhoc5aYPMrIdDLE1xY+Gn+88yKTMD8vgUfqdwfk1CuIdfG3rBKH0iXd9ZC?=
 =?us-ascii?Q?DURuo11qfyqA4Q/FXyguzDF1Dt8HBMLPQWMlo6YCu915VPCVB72+haR4zUtc?=
 =?us-ascii?Q?f9/o6ClEaGlW7SZ5r0se5mUekkCuFKCaBcInE279vYAe9iNbp4w6lpGeq7N3?=
 =?us-ascii?Q?PqZHUxKmXnhR0Iy/GspvyoBFETTsPFRZoKdoepO8lVXxKr8odMpdErxLJD7t?=
 =?us-ascii?Q?Ki5iM2je6d9+u8EHBEurP+BQwsdcFbJg4+8R8d5rF4NhfRoNeMxC4RUx6sEn?=
 =?us-ascii?Q?QStBKf6MK9RG1PWbRTkUAH1O7bxfyUV2fDlE8FunXgIiWZ0rBH7bz4wPb346?=
 =?us-ascii?Q?67J8EVzUZ/1/J8SVelt6STvFwNk2PYXq3oWFJGSMUszw0zIGPaGzIvkkHEaK?=
 =?us-ascii?Q?QfparqB70c7Sd9vlV3io7dIJd5m7+48fJPlrWEIOHlZAWEbHKCSFte7YIo1B?=
 =?us-ascii?Q?3qEHkXPPrs2pbIQn4UQbkmZxfBs99r4xn3SfU0V8dHE6rzEdDFkg6BZoznp8?=
 =?us-ascii?Q?iIfhBpkBmP4BQiXU4rVZDR7y2yIljmFlJjMnYzWXrP974PVRqqxA9LZ17MJc?=
 =?us-ascii?Q?f2yBFrli8Kk2BNSn33Me977y4GmcFGBzurwSwRo4gTNItN3I82CzB7M8z19Y?=
 =?us-ascii?Q?rRt+3yPD7sbZBsJ/1NfT3VVG+TjaHuWo34rvjazuGaE8s2/qNd84QuOXPbxa?=
 =?us-ascii?Q?EKxeoI4tKPR2opPO0Qxxs3qAQfTNbJFVpuDMs2I2Zmnh3U5Vb6KKEm78NKaZ?=
 =?us-ascii?Q?m+7kXTX2iB4vfHo6wy5kCYqMSoAJmGeyGUD1nvqI1izhWkmuc7vFNwP3THTZ?=
 =?us-ascii?Q?FP0uqTLbnl6/xFZGwr8zOVXkATQ56F15LemcfmwHZlfyVw6rOt9PbtPsYQ3A?=
 =?us-ascii?Q?XtDWpeda6y3m9bjEISN7ri9Iy+XvtAkh6kHs8IaJVbig32VQLlyxYxBDtZj/?=
 =?us-ascii?Q?nf+m9UxtSw740n3kNMxKKDkSySYHtbnghCkXqyXaoxBGuW/8eJyz9+/VJOgs?=
 =?us-ascii?Q?dnDbEl70V5ZPZmMSPWF9eplm573jFpTjzaogelAtwX2CQnEIZl6KSfwBuhj5?=
 =?us-ascii?Q?HY0R7JGr/0h6bd4naXUTwBUpNqeV+mKRT1mE1YRU9kFyy2g5ipZRW7ya4tdp?=
 =?us-ascii?Q?j5GbOof9Et31qH+li3LjNNSdw6BUeYbafnIUc3XvdnVLe7sE8FwVNFcTtrrv?=
 =?us-ascii?Q?s9rweCgPoBF8Qnlj4YuUJ8wiZ2GujsluVNesTikWbcCnTlaEOhIRI4F2BkC+?=
 =?us-ascii?Q?3VDz1/G8cwhHLyhr35x9SUcztuD0IaRMqaJkWvf9Lg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WWbWpe/X0PXR1qLtWCXnnZvvREHy5tu58yotfO+32/Hq6mkhCtKdd38IYpuw?=
 =?us-ascii?Q?p197XAnn3ribeSXVoFodRqejyfMYCHRR3jM/x/PsR97uX0HoeymoHniociy6?=
 =?us-ascii?Q?bhNdek2/z8u3eyVYU6FMLxTuE0GRptE065OgzahVrIYlzrdRJRbNYCNrB0ry?=
 =?us-ascii?Q?/f6pg3aicubVlm8V4YDhdbCKUegRjTjXqvY+xZivHiETgkETibqRSpE1jt9L?=
 =?us-ascii?Q?rnNtr8ZfSUGnhoPaUwp2dYfKsaNBhOt4O48ecTtKtKZ5h9AGL3vdpVf5OiyA?=
 =?us-ascii?Q?2LimNkyqX1sW94P5p9jau6Ad8sq5awHmnRvu69cmlKOGMQegiS2rPydR/AnE?=
 =?us-ascii?Q?C6wHci/d5efo6km5azC0CSfBw9HxethmM8CEvUYUyanjWck/sSdeFtU1UC+r?=
 =?us-ascii?Q?y6PwxZe4H2KffFE4dKjQKqMpzeKHiWZrGUWvO++WxiCgy6Q/AT97a00jz0fV?=
 =?us-ascii?Q?KKCpJvCE3lJ/VTOz05IRLNGSOHmS7d43gTrBB46S/lmCuL5hXmjgxjWD7x4n?=
 =?us-ascii?Q?UuX0uVaP+TL7Ru/Ch9tJ+aliMWGPU0SwcvT9Lx9DzOHxym0RH0AyA3uNkf78?=
 =?us-ascii?Q?gd9ZgxbKnbQTOASG473yjzy4zR4yVf+4BZ5kY2CMGrihswYMCrg12dW/AHa3?=
 =?us-ascii?Q?d/Qk7op2JrveB2y4ZKCTxsi62/5z54p6vCzcawAJBDzvxIPSX0Rum0tWHsJE?=
 =?us-ascii?Q?TXJwK6X2U858qgSI5iWN+LRqeYAwrdUU5vhcWp4uG+oD9GEji9M7pb01DXpA?=
 =?us-ascii?Q?N3fohLoNRX4XEXDS7BDgEeLgx3QesmMlfdzCKDYBbSc3cIlIHBUKqqqjBuob?=
 =?us-ascii?Q?nWeIg/hgDBSjlRZjre9e7eeC1Den42yPuE5ff+ZtPqSoyvh8eCDQ9bvCtz0i?=
 =?us-ascii?Q?V8fnXsivQePFsHNyLxFRUC1Pgn49Yqwk6EdhEN6m3J/1jdmdxRqNTsYosZJj?=
 =?us-ascii?Q?dHTdKLeFnvopMSfavPTt7Q7eMMNsTMWmYbUjr8KDCT+484DgvDP5d/VJDeWk?=
 =?us-ascii?Q?YuZs9L93PBB4yK/EZnlgf/wVW/9CMj40jdOFBKvOUw2hzTje72fELNJF8O5B?=
 =?us-ascii?Q?JRTxfKBUW29UO/j8BkojyNyYPlhxC1GCSkBHDJ/M5zoxxQA6sWxyFh8puHpk?=
 =?us-ascii?Q?976brChJCoKDbYPwuVubyo4oqjoE3LBGUPQPCa0zaUislrkg254my/fHFEyX?=
 =?us-ascii?Q?aXGHQ/yyPVXRYZptc4VzpJzFUvH8BBoGFWRINw56MEDg2F788lkMxKzahLQ4?=
 =?us-ascii?Q?YXXXEEVO3bUmuRxh/UtuF/88csNLYAfg/TkRdW9+8Eqm/380jxNuj4gluItf?=
 =?us-ascii?Q?czzzdx+EXwoEds0U548Ez5JZQsWnBHgp3jPdCemNTxpH9mdbUZWynAoX7AOT?=
 =?us-ascii?Q?QKE0G047UYts4RifKs+32fnasIqB5Xzua50rTAeEIEXevaZgCDdSbdg5YmO7?=
 =?us-ascii?Q?MLUhG3VS62ze4SH19C4bX+n3iuObwakVjzOCxAQ0KqrAIh5UEqIssJeUy2nX?=
 =?us-ascii?Q?h5V+YIfbNF0uWQUOcCTLuPngxq3AyzM8HF6maBW5MvgzxMf1CFJlg7fV/TzF?=
 =?us-ascii?Q?KK+GJPw2dhdBGEqSYTjmbNeBAsEfRl5ABGMfU6fhb2tdsys4XRzny7HKOWaU?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ac1493-583f-43d7-aa7a-08dce7303519
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 00:29:01.6403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wW7iVzt6YXMEtszYVaUfn3CH1pI3esD4+RtPJtubA2GiVPZ6nNqRSJWEBTjmY76qpKboZuQbkn+bcSx9T3FaIIkbdqhBin4UfOw7yw6ysAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7641
X-OriginatorOrg: intel.com

Gerald Schaefer wrote:
[..]
> When you also remove the now unused dax_dev definition at the top of
> dcssblk_add_store(), as noticed by kernel test robot:

Yup, already have that fixup locally.

> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>

Thanks!
