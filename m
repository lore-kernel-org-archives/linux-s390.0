Return-Path: <owner-linux-mm@kvack.org>
Date: Tue, 27 Nov 2018 15:36:38 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] mm: warn only once if page table misaccounting is
 detected
References: <20181127083603.39041-1-heiko.carstens@de.ibm.com>
 <20181127131916.GX12455@dhcp22.suse.cz>
MIME-Version: 1.0
In-Reply-To: <20181127131916.GX12455@dhcp22.suse.cz>
Message-Id: <20181127143638.GE3625@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, "Kirill A . Shutemov" <kirill@shutemov.name>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Nov 27, 2018 at 02:19:16PM +0100, Michal Hocko wrote:
> On Tue 27-11-18 09:36:03, Heiko Carstens wrote:
> > Use pr_alert_once() instead of pr_alert() if page table misaccounting
> > has been detected.
> > 
> > If this happens once it is very likely that there will be numerous
> > other occurrence as well, which would flood dmesg and the console with
> > hardly any added information. Therefore print the warning only once.
> 
> Have you actually experience a flood of these messages? Is one per mm
> message really that much?

Yes, I did. Since in this case all compat processes caused the message
to appear, I saw thousands of these messages.

> If yes why rss counters do not exhibit the same problem?

No rss counter messages appeared. Or do you suggest that the other
pr_alert() within check_mm() should also be changed?
