Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 11 Oct 2020 13:23:12 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
Subject: Re: VM_BUG_ON_PAGE(page_to_pgoff(page) != offset) on s390
In-Reply-To: <20200617031906.GA5065@lca.pw>
Message-ID: <alpine.LSU.2.11.2010111321430.15963@eggly.anvils>
References: <20200616013309.GB815@lca.pw> <20200616014859.GY8681@bombadil.infradead.org> <20200617031906.GA5065@lca.pw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@lca.pw>
Cc: Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, darrick.wong@oracle.com, kirill@shutemov.name, peterx@redhat.com, yang.shi@linux.alibaba.com, hch@lst.de, linux-kernel@vger.kernel.org, songliubraving@fb.com

Adding a note to update this thread: the v5.9 tree now has
033b5d775511 ("mm/khugepaged: fix filemap page_to_pgoff(page) != offset")
which fixes this VM_BUG_ON_PAGE (or data corruption) when CONFIG_NUMA
is not set: we are hoping that may have have been the problem here.
