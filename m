From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2] s390: ensure that syscall arguments are properly
	masked on s390
Date: Tue, 28 Jun 2016 06:51:12 +0200
Message-ID: <20160628045112.GA3784@osiris>
References: <146703807642.15496.11673601281156224299.stgit@localhost>
	<CAGH-KgunDc74vuRa=z4yF8x5Ccxcery8-Ya1AqxdpAjaXEBxGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audit-bounces@redhat.com>
Content-Disposition: inline
In-Reply-To: <CAGH-KgunDc74vuRa=z4yF8x5Ccxcery8-Ya1AqxdpAjaXEBxGQ@mail.gmail.com>
List-Unsubscribe: <https://www.redhat.com/mailman/options/linux-audit>,
	<mailto:linux-audit-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/linux-audit>
List-Post: <mailto:linux-audit@redhat.com>
List-Help: <mailto:linux-audit-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/linux-audit>,
	<mailto:linux-audit-request@redhat.com?subject=subscribe>
Sender: linux-audit-bounces@redhat.com
Errors-To: linux-audit-bounces@redhat.com
List-Archive: <https://lore.kernel.org/linux-audit/>
To: Paul Moore <pmoore@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-audit@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jun 27, 2016 at 10:37:59AM -0400, Paul Moore wrote:
> On Mon, Jun 27, 2016 at 10:34 AM, Paul Moore <pmoore@redhat.com> wrote:
> > From: Paul Moore <paul@paul-moore.com>
> >
> > When executing s390 code on s390x the syscall arguments are not
> > properly masked, leading to some malformed audit records.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  arch/s390/kernel/ptrace.c |   10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> The only change between v2 and the original patch is the use of
> is_compat_task() instead of the #ifdef, as suggested by Heiko.  Like
> before, I've added this patch to the audit#next branch; I think we
> have sorted all the feedback, but if any objections remain please let
> me know.

Thanks!

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
