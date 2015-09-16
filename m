From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Fixes: 805de8f43c20 (atomic: Replace
 atomic_{set,clear}_mask() usage)
Date: Wed, 16 Sep 2015 16:40:07 +0200
Message-ID: <20150916144007.GB3604@twins.programming.kicks-ass.net>
References: <1442409230-10806-1-git-send-email-jjherne@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442409230-10806-1-git-send-email-jjherne@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Cc: pbonzini@redhat.com, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, tglx@linutronix.de, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Sep 16, 2015 at 09:13:50AM -0400, Jason J. Herne wrote:
> The offending commit accidentally replaces an atomic_clear with an
> atomic_or instead of an atomic_andnot in kvm_s390_vcpu_request_handled.
> The symptom is that kvm guests on s390 hang on startup.
> This patch simply replaces the incorrect atomic_or with atomic_andnot
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>

Urgh, sorry about that.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
