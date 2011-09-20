Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 20 Sep 2011 16:00:12 -0700
From: Andrew Morton <akpm@google.com>
Subject: Re: [patch 0/2] kdump: Initialize vmcoreinfo note at startup
Message-Id: <20110920160012.53b941a7.akpm@google.com>
In-Reply-To: <20110920143400.776127689@linux.vnet.ibm.com>
References: <20110920143400.776127689@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: vgoyal@redhat.com, ebiederm@xmission.com, mahesh@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 20 Sep 2011 16:34:00 +0200
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> Hello Andrew,
> 
> Another common code patch that we would like to have upstream is the vmcoreinfo
> note initialization at Linux startup time. We need that for our traditional
> stand-alone and hypervisor dump tools.
> 
> [1] kdump: Initialize vmcoreinfo note at startup
> [2] s390: Export vmcoreinfo note
> 
> I already have discussed this with Vivek and he has acked the common code
> patch [1].
> 
> Do you agree that Martin sends these patches together with the kdump page
> table patches (see https://lkml.org/lkml/2011/9/15/55) in the next merge
> window?

Sounds good to me, thanks.
