Return-Path: <linux-kernel-owner+w=401wt.eu-S1756197AbYAQOFh@vger.kernel.org>
Subject: Re: 2.6.24-rc8-mm1 Build Failure on S390x
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <478F4D05.2070803@linux.vnet.ibm.com>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
	 <478F4D05.2070803@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Thu, 17 Jan 2008 15:05:34 +0100
Message-Id: <1200578734.8573.1.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux390@de.ibm.com, linux-s390@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2008-01-17 at 18:11 +0530, Kamalesh Babulal wrote:
> The 2.6.24-rc8-mm1 kernel build fails on S390x with build error

This is the fallout from the merge conflict between git390 and Gregs git
tree. This will stay broken until Gregs tree has been merged. Please
ignore the compile failures for now.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
