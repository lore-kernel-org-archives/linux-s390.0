From: Collin Walling <walling@linux.ibm.com>
Date: Fri, 31 Aug 2018 19:31:09 +0000
Subject: Re: [RFC PATCH 0/3] Use DIAG318 to set Control Program Name & Version Codes
Message-Id: <dcf5cb6c-3671-3cc9-7243-862b71071d14@linux.ibm.com>
In-Reply-To: <1535734279-10204-1-git-send-email-walling@linux.ibm.com>
References: <1535734279-10204-1-git-send-email-walling@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 08/31/2018 12:51 PM, Collin Walling wrote:
> A new diagnose instruction, 318, allows the kernel to set an 8-byte "Control 
> Program Code" (CPC) that is composed of:
> 
>     1-byte Control Program Name Code (CPNC)
>     7-byte Control Program Version Code (CPVC) composed of:
>         3-bytes for Linux Kernel version (determined at build-time)
>         3-bytes for Distribution Identifier (referred to as distro_id; set by Kconfig option)
>         1-byte trailing NULL
> 
> Note about distro_id:
> [
> The initial idea for the 3-byte distro_id is for each distribution to set 
> three characters that correspond to their distribution name (for a theoretical 
> distributor "ACME," they could set "ACM" as the distro_id). A registry file 
> could be included in the s390 kernel documentation to avoid name collisions.
> ]

Another (likely better) idea is to use 1-byte for the distribution, followed
by 2-bytes for major.minor release.




-- 
Respectfully,
- Collin Walling
