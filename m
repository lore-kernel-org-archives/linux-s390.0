Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 19 May 2014 09:18:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: gather_hugetbl_stats() doesn't use huge_pte...() variants
Message-ID: <20140519091817.559e550b@mschwide>
In-Reply-To: <537645D1.7020403@intel.com>
References: <537645D1.7020403@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux390@de.ibm.com, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

On Fri, 16 May 2014 10:07:29 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> Is the numa maps gather_hugetbl_stats() buggy on s390?  It uses the
> normal pte_ variants.

That would be broken if we ever enable CONFIG_NUMA. Right now s390 does
not support NUMA, the gather_hugetbl_stats code is dead code for us.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
