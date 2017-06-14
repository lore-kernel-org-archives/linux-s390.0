Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1497448151.18751.53.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: [HLP]LIST_HEAD is also declaration
From: Joe Perches <joe@perches.com>
Date: Wed, 14 Jun 2017 06:49:11 -0700
In-Reply-To: <bc6acd66-af18-951e-d2a5-24ca71f1e615@linux.vnet.ibm.com>
References: <1497437132.18751.45.camel@perches.com>
         <20170614133512.89425-1-maier@linux.vnet.ibm.com>
         <bc6acd66-af18-951e-d2a5-24ca71f1e615@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Steffen Maier <maier@linux.vnet.ibm.com>, Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2017-06-14 at 15:43 +0200, Steffen Maier wrote:
> Sorry, only realized after sending v2, that you also mentioned SLIST_HEAD, which I haven't found on git grep'ing include/ only.
> 
> I could only find SLIST_HEAD (and even another variant) in some driver private header.
> Am I searching in a wrong way?
> If not, shall we still add this like the other official list APIs?

No worries.
checkpatch is not and never will be free of false-positives.

I had done git grep -E "define\s+[A-Z]?LIST_HEAD" and
listed the results but I wouldn't bother with SLIST_HEAD.

It's private to one driver.


> Linus' tree at:
> $ git branch -vv
> * master   63f700aab4c1 [origin/master] Merge tag 'xtensa-20170612' of git://github.com/jcmvbkbc/linux-xtensa
> 
> $ git grep 'define.*LIST_HEAD('
> drivers/gpu/drm/nouveau/include/nvif/list.h:124:#define LIST_HEAD(name) \
> drivers/gpu/drm/radeon/mkregtable.c:47:#define LIST_HEAD(name) \
> drivers/scsi/aic7xxx/queue.h:107:#define        SLIST_HEAD(name, type)                                          \
> drivers/scsi/aic7xxx/queue.h:249:#define        BSD_LIST_HEAD(name, type)                                       \
> include/linux/list.h:22:#define LIST_HEAD(name) \
> include/linux/list.h:625:#define HLIST_HEAD(name) struct hlist_head name = {  .first = NULL }
> include/linux/list.h:626:#define INIT_HLIST_HEAD(ptr) ((ptr)->first = NULL)
> include/linux/llist.h:75:#define LLIST_HEAD(name)       struct llist_head name = LLIST_HEAD_INIT(name)
> include/linux/plist.h:104:#define PLIST_HEAD(head) \
> include/linux/shm.h:57:#define shm_init_task(task) INIT_LIST_HEAD(&(task)->sysvshm.shm_clist)
> scripts/kconfig/list.h:30:#define LIST_HEAD(name) \
> tools/include/linux/list.h:21:#define LIST_HEAD(name) \
> tools/include/linux/list.h:595:#define HLIST_HEAD(name) struct hlist_head name = {  .first = NULL }
> tools/include/linux/list.h:596:#define INIT_HLIST_HEAD(ptr) ((ptr)->first = NULL)
> tools/usb/usbip/libsrc/list.h:24:#define LIST_HEAD(name) \
> 
> 
> On 06/14/2017 03:35 PM, Steffen Maier wrote:
> > Fixes the following false warning
> > among others for LLIST_HEAD and PLIST_HEAD:
> > 
> >      WARNING: Missing a blank line after declarations
> >      #71: FILE: drivers/s390/scsi/zfcp_fsf.c:422:
> >      +	struct hlist_node *tmp;
> >      +	HLIST_HEAD(remove_queue);
> > 
> > Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
> > ---
> > Changes from v1:
> > Extended it to also support LLIST_HEAD and PLIST_HEAD as suggested by
> > Joe Perches.
> > 
> >   scripts/checkpatch.pl | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 4b9569fa931b..86818b0ba8be 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -732,7 +732,7 @@ our $FuncArg = qr{$Typecast{0,1}($LvalOrFunc|$Constant|$String)};
> > 
> >   our $declaration_macros = qr{(?x:
> >   	(?:$Storage\s+)?(?:[A-Z_][A-Z0-9]*_){0,2}(?:DEFINE|DECLARE)(?:_[A-Z0-9]+){1,6}\s*\(|
> > -	(?:$Storage\s+)?LIST_HEAD\s*\(|
> > +	(?:$Storage\s+)?[HLP]?LIST_HEAD\s*\(|
> >   	(?:$Storage\s+)?${Type}\s+uninitialized_var\s*\(
> >   )};
> > 
> 
> 
