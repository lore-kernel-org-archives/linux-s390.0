Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 11 Apr 2013 13:25:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] aio: convert the ioctx list to radix tree
Message-Id: <20130411132547.cd0df05abeea6a7f49646b0c@linux-foundation.org>
In-Reply-To: <1364995248-11028-1-git-send-email-octavian.purdila@intel.com>
References: <1364995248-11028-1-git-send-email-octavian.purdila@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org, linux-s390@vger.kernel.org, koverstreet@google.com, bcrl@kvack.org, schwidefsky@de.ibm.com, kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed,  3 Apr 2013 16:20:48 +0300 Octavian Purdila <octavian.purdila@intel.com> wrote:

> This patchs converts the ioctx list to a radix tree.

This looks rather nice, but unfortunately all the pending aio work in
-mm/linux-next totally messes it up.

Could you please redo and retest it over the pending work?  Perhaps
after 3.10-rc1 would be a convenient time.
